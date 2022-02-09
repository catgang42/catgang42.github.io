using UnityEngine;
using System.Collections;

public class ItemBehavior : PE_Obj2D {
	public LayerMask GroundLayers;
	private Transform is_on_ground;
	public bool canJump;
	public bool canJump2;
	public bool mushroom;
	public bool tanooki;
	public bool coin;
	public bool multiplier;
	public bool destroyed = false;
	public bool spawned = false;
	public float end_pos;
	private float tanooki_speed = 5.0f;
	private Animator anim;
	public float timer = 0;
	public AudioClip itemsound;
	// Use this for initialization

	void playSound(AudioClip sound, float vol){
		GetComponent<AudioSource>().clip = sound;
		GetComponent<AudioSource>().volume = vol;
		GetComponent<AudioSource>().Play();
	}

	public override void Start () {
		is_on_ground = transform.FindChild("IsOnGround");
		anim = GetComponent<Animator>();
		timer = 0;
		if (tanooki) {
			vel.y = 10.0f;
		}
		else {
			playSound (itemsound, 1.0f);
		}
		base.Start ();
	}
	// Update is called once per frame
	void Update () {
		if (coin) {
			Vector3 newPos = new Vector3(transform.position.x, transform.position.y + .3f, transform.position.z);
			if (newPos.y >= end_pos) {
				Destroy (transform.gameObject);
			}
			transform.position = newPos;
			return;
		}
		Vector2 point1 = new Vector2(is_on_ground.transform.position.x - is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y - is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		Vector2 point2 = new Vector2(is_on_ground.transform.position.x + is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y + is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		canJump = Physics2D.OverlapArea(point1, point2, GroundLayers, 0, 0);
		// next bool needed so that you can't jump off walls
		canJump2 = Physics2D.OverlapPoint(is_on_ground.position, GroundLayers);
		if (canJump2 && !tanooki) {
			vel.y = 0;
			acc.y = 0;
		}
		else if (!canJump2 && !tanooki) {
			acc.y = -60.0f;
			// terminal velocity
			if (vel.y <= -15.0f) {
				acc.y = 0;
				vel.y = -15.0f;
			}
		}
		if (!tanooki && !coin && timer < 1.0f) {
			Vector3 newPos = new Vector3(transform.position.x, transform.position.y + .07f, transform.position.z);
			if (newPos.y >= end_pos) {
				newPos.y = end_pos;
			}
			transform.position = newPos;
		}
		if (mushroom && timer >= 1.0f && !spawned) {
			vel.x = -3.0f;
			// transform.FindChild("IsOnGround").GetComponent<PE_Obj2D>().vel.x = -3.0f;
			timer = 0;
			spawned = true;
		}
		anim.speed = 1.0f + Mathf.Pow (timer/7.0f,7);
		if (timer >= 5.0f) {
			anim.SetBool("Disappear", true);
		}
		if ((destroyed) || (timer >= 10.0f)) {
			PhysEngine2D.objs.Remove(transform.gameObject.GetComponent<PE_Obj2D>());
			Destroy (transform.gameObject);
		}
		if (tanooki && transform.position.y >= end_pos) {
			vel.y = -1.5f;
			vel.x = tanooki_speed;
			transform.localScale = new Vector3(-Mathf.Sign(tanooki_speed), 1, 1);
			timer = 0;
		}
		if (tanooki && timer > 0.4f) {
			vel.x = 0;
			vel.y = 0;
		}
		if (tanooki && timer > 0.5f) {
			tanooki_speed = -tanooki_speed;
			vel.y = -1.5f;
			transform.localScale = new Vector3(-Mathf.Sign(tanooki_speed), 1, 1);
			vel.x = tanooki_speed;
			timer = 0;
		}
		timer += Time.fixedDeltaTime;
	}

	public override void OnTriggerEnter2D(Collider2D otherColl){
		PE_Obj2D other = otherColl.gameObject.GetComponent<PE_Obj2D>();
		if (other == null) {
			return;
		}
		else if (((other.gameObject.tag == "Block_item" && timer > 1.0f) || other.gameObject.tag == "Block_empty") && 
		         (transform.position.y < otherColl.transform.position.y + otherColl.GetComponent<Collider2D>().bounds.size.y/2)) {
			vel.x = -vel.x;
			float sign = Mathf.Sign (vel.x);
			transform.position = new Vector2(transform.position.x + sign * 0.1f, transform.position.y);
			transform.localScale = new Vector3(sign, 1, 1);
			base.OnTriggerEnter2D(otherColl);
		}
		else if (other.gameObject.tag == "Block_item" && (transform.position.y < end_pos) && !tanooki) {}
		else if (tanooki && other.gameObject.tag != "Player") {}
		else {
			base.OnTriggerEnter2D(otherColl);
		}
	}
	
	public override void OnTriggerStay2D(Collider2D other){
		OnTriggerEnter2D(other);
	}

}
