using UnityEngine;
using System.Collections;

public enum PowerUp {
	none,
	mushroom,
	tanooki
}

public class Health : MonoBehaviour {
	public bool big = false;
	public bool tanooki = false;
	public bool gothurt = false;
	public bool felloff;
	public int item_number = 0;
	public PowerUp type = PowerUp.none;
	public GameObject mario_small;
	public GameObject mario_big;
	public GameObject mario_tanooki;
	public GameObject mario;
	public Transform GameManager;
	public Animator anim;
	public float timer;
	public bool invincible;
	public bool invincibility_mode;
	public AudioClip CoinSound;
	public AudioClip shrink_sound;
	public AudioClip tanooki_obtained;
	public AudioClip downed;
	public AudioClip grow_bigger;
	Vector2 position;
	Vector2 holderPos;
	public float pauseEndTime;
	private bool dead;
	private bool move_up;
	public bool cloned;
	Vector2 top_pos;
	public void playSound(AudioClip sound, float vol){
		GetComponent<AudioSource>().clip = sound;
		GetComponent<AudioSource>().volume = vol;
		GetComponent<AudioSource>().Play();
	}

	// Use this for initialization
	void Start () {
		GameManager = transform.FindChild("GameManager");
		
		mario_small = GameObject.Find ("Mario");
		mario_big = GameObject.Find ("Mario_Big");
		mario_tanooki = GameObject.Find ("Mario_Tanooki");

		anim = mario_small.GetComponent<Animator>();
		big = false;
		tanooki = false;
		mario_small.gameObject.SetActive(true);
		mario_big.gameObject.SetActive(false);
		mario_tanooki.gameObject.SetActive(false);
		timer = 10.0f;
		holderPos = new Vector2(-13.0f,0.0f);
	}
	void Update () {
		if (Input.GetKeyDown (KeyCode.G)) {
			print("Pressed G key");
			invincibility_mode = !invincibility_mode;
		}
		if (invincibility_mode) {
			invincible = true;
		}
		if (cloned) {
//			GameObject clone = GameObject.Find ("Mario(Clone)");
//			if (clone.transform.position.x > mario_small.transform.position.x + 2.0f)
//				clone.transform.position = new Vector2(mario_small.transform.position.x + 1.9f, clone.transform.position.y);
//			else if (clone.transform.position.x < mario_small.transform.position.x - 2.0f)
//				clone.transform.position = new Vector2(mario_small.transform.position.x - 1.9f, clone.transform.position.y);
		}
	}
	// Update is called once per frame
	void FixedUpdate () {
		if ((timer > 3.0f) && invincible && !invincibility_mode){
			invincible = false;
			gothurt = false;
		}
		if (((gothurt && !big && !invincible) || (felloff)) && !dead) {
			GameManager.GetComponent<AudioSource>().Stop ();
			anim.SetBool("Dead", true);
			playSound (downed, 0.1f);
			gothurt = false;
			// make mario die
			pauseEndTime = Time.realtimeSinceStartup + 4.0f;
			move_up = true;
			top_pos = new Vector2(mario_small.transform.position.x, mario_small.transform.position.y + 2.0f);
			Time.timeScale = 0.001f;
			dead = true;
//			bool move_up = true;
//			Vector2 top_pos = new Vector2(mario_small.transform.position.x, mario_small.transform.position.y + 2.0f);
			while (Time.realtimeSinceStartup < pauseEndTime) {
//				if (!felloff) {
//					if (move_up) {
//						Vector2 new_pos = new Vector2(mario_small.transform.position.x, mario_small.transform.position.y + 0.1f);
//						mario_small.transform.position = new_pos;
//						if (new_pos.y >= top_pos.y)
//							move_up = false;
//					}
//					else {
//						Vector2 new_pos = new Vector2(mario_small.transform.position.x, mario_small.transform.position.y - 0.1f);
//						mario_small.transform.position = new_pos;
//					}
//				}
			}
			Application.LoadLevel(Application.loadedLevel);
			
			PhysEngine2D.objs.Remove(mario_small.GetComponent<PE_Obj2D>());
			// Time.timeScale = 1;
		}
		else if (dead) {
//			if (!felloff) {
//				if (move_up) {
//					Vector2 new_pos = new Vector2(mario_small.transform.position.x, mario_small.transform.position.y + 0.1f);
//					mario_small.transform.position = new_pos;
//					if (new_pos.y >= top_pos.y)
//						move_up = false;
//				}
//				else {
//					Vector2 new_pos = new Vector2(mario_small.transform.position.x, mario_small.transform.position.y - 0.1f);
//					mario_small.transform.position = new_pos;
//				}
//			}
//			if (Time.realtimeSinceStartup > pauseEndTime) {
//				Application.LoadLevel(Application.loadedLevel);
//			}
//			return;
		}
		else if (gothurt && !invincible && (type == PowerUp.mushroom)){
			playSound (shrink_sound, 0.1f);
			// make mario lose powerup
			gothurt = false;
			Time.timeScale = 0.001f;
			float pauseEndTime = Time.realtimeSinceStartup + 0.01f;
			// delete small mario and add big mario
			//Instantiate(mario_small, mario_big.transform.position, mario_big.transform.rotation);
			Vector3 facingDirection = new Vector3(mario_big.transform.localScale.x, mario_big.transform.localScale.y,
			                         mario_big.transform.localScale.z);
			Vector3 loc = new Vector2(mario_big.transform.position.x, mario_big.transform.position.y - 0.4f);
			mario_small.GetComponent<PE_Obj2D>().vel = mario_big.GetComponent<PE_Obj2D>().vel;
			mario_big.gameObject.SetActive(false);
			mario_small.transform.localScale = facingDirection;
			mario_small.transform.position = loc;
			mario_small.gameObject.SetActive(true);
			timer = 0;
			invincible = true;
			// PhysEngine2D.objs.Remove(mario_big.GetComponent<PE_Obj2D>());
			//Destroy (mario_big);
			//mario_big.active = false;
			anim = mario_small.GetComponent<Animator>();
			anim.speed = 1.0f/Time.timeScale;
			// play small to big mario animation
			//anim.SetBool("Mushroom", true);
			
			//anim.SetBool("Mushroom", false);
			while (Time.realtimeSinceStartup < pauseEndTime) {}
			anim.speed = 1.0f;
			Time.timeScale = 1;
			big = false;
			type = PowerUp.none;
			mario_small.GetComponent<PlayerMovement>().big = false;
		}
		else if (gothurt && !invincible && (type == PowerUp.tanooki)){
			playSound (tanooki_obtained, 0.1f);
			// make mario lose powerup
			gothurt = false;
			Time.timeScale = 0.001f;
			float pauseEndTime = Time.realtimeSinceStartup + 0.01f;
			// delete small mario and add big mario
			//Instantiate(mario_small, mario_big.transform.position, mario_big.transform.rotation);
			Vector3 facingDirection = new Vector3(mario_tanooki.transform.localScale.x, mario_tanooki.transform.localScale.y,
			                                      mario_tanooki.transform.localScale.z);
			mario_big.GetComponent<PE_Obj2D>().vel = mario_tanooki.GetComponent<PE_Obj2D>().vel;
			Vector3 loc = new Vector2(mario_tanooki.transform.position.x, mario_tanooki.transform.position.y);
			mario_tanooki.gameObject.SetActive(false);
			mario_big.transform.localScale = facingDirection;
			mario_big.transform.position = loc;
			mario_big.gameObject.SetActive(true);
			timer = 0;
			invincible = true;
			// PhysEngine2D.objs.Remove(mario_big.GetComponent<PE_Obj2D>());
			//Destroy (mario_big);
			//mario_big.active = false;
			anim = mario_big.GetComponent<Animator>();
			anim.speed = 1.0f/Time.timeScale;
			// play small to big mario animation
			//anim.SetBool("Mushroom", true);
			
			//anim.SetBool("Mushroom", false);
			while (Time.realtimeSinceStartup < pauseEndTime) {}
			anim.speed = 1.0f;
			Time.timeScale = 1;
			big = true;
			tanooki = false;
			type = PowerUp.mushroom;
			mario_big.GetComponent<PlayerMovement>().big = true;
		}
		// mushroom
		if (item_number == 1) {
			if (!big) {
				playSound (grow_bigger, 0.1f);
				// freeze time
				Time.timeScale = 0.00f;
				float pauseEndTime = Time.realtimeSinceStartup + 0.01f;
				// delete small mario and add big mario
				Vector3 facingDirection = new Vector3(mario_small.transform.localScale.x, mario_small.transform.localScale.y, mario_small.transform.localScale.z);
				Vector2 loc = new Vector2(mario_small.transform.position.x, mario_small.transform.position.y + 0.4f);
				mario_big.GetComponent<PE_Obj2D>().vel = mario_small.GetComponent<PE_Obj2D>().vel;

				mario_big.transform.localScale = facingDirection;
				mario_big.transform.position = loc;
				mario_small.gameObject.SetActive(false);
				mario_big.gameObject.SetActive(true);

				// Instantiate(mario_big, mario_small.transform.position, mario_small.transform.rotation);
				//mario_big.transform.localScale = new Vector3 (mario_small.transform.localScale.x, mario_small.transform.localScale.y,
				                                             // mario_small.transform.localScale.z);
				// mario_small.active = false;
				// PhysEngine2D.objs.Remove(mario_small.GetComponent<PE_Obj2D>());
				// Destroy (mario_small);
				anim = mario_big.GetComponent<Animator>();
				anim.speed = 1.0f/Time.timeScale;
				// play small to big mario animation
				//anim.SetBool("Mushroom", true);

				//anim.SetBool("Mushroom", false);
				while (Time.realtimeSinceStartup < pauseEndTime) {}
				anim.speed = 1.0f;
				Time.timeScale = 1;
				type = PowerUp.mushroom;
				big = true;
				mario_big.GetComponent<PlayerMovement>().big = true;
			}
			item_number = 0;
		}
		// tanooki
		else if (item_number == 2) {
			playSound (tanooki_obtained, 0.1f);
			if (!tanooki) {
				// freeze time
				Time.timeScale = 0.00f;
				float pauseEndTime = Time.realtimeSinceStartup + 0.01f;
				// delete small mario and add big mario
				Vector3 facingDirection;
				Vector2 loc;
				if (mario_big.activeSelf) {
					mario_big.gameObject.SetActive(false);
					facingDirection = new Vector3(mario_big.transform.localScale.x, mario_big.transform.localScale.y, mario_big.transform.localScale.z);
					loc = new Vector2(mario_big.transform.position.x, mario_big.transform.position.y);
					mario_tanooki.GetComponent<PE_Obj2D>().vel = mario_big.GetComponent<PE_Obj2D>().vel;
				}
				else {
					mario_small.gameObject.SetActive(false);
					facingDirection = new Vector3(mario_small.transform.localScale.x, mario_small.transform.localScale.y, mario_small.transform.localScale.z);
					loc = new Vector2(mario_small.transform.position.x, mario_small.transform.position.y);
					mario_tanooki.GetComponent<PE_Obj2D>().vel = mario_small.GetComponent<PE_Obj2D>().vel;
				}
				mario_tanooki.transform.localScale = facingDirection;
				mario_tanooki.transform.position = loc;
				mario_tanooki.gameObject.GetComponent<PlayerMovement>().tail.gameObject.SetActive(false);
				mario_tanooki.gameObject.SetActive(true);
				// Instantiate(mario_big, mario_small.transform.position, mario_small.transform.rotation);
				//mario_big.transform.localScale = new Vector3 (mario_small.transform.localScale.x, mario_small.transform.localScale.y,
				// mario_small.transform.localScale.z);
				// mario_small.active = false;
				// PhysEngine2D.objs.Remove(mario_small.GetComponent<PE_Obj2D>());
				// Destroy (mario_small);
				anim = mario_tanooki.GetComponent<Animator>();
				anim.speed = 1.0f/Time.timeScale;
				// play small to big mario animation
				//anim.SetBool("Mushroom", true);
				
				//anim.SetBool("Mushroom", false);
				while (Time.realtimeSinceStartup < pauseEndTime) {}
				anim.speed = 1.0f;
				Time.timeScale = 1;
				tanooki = true;
				type = PowerUp.tanooki;
				mario_tanooki.GetComponent<PlayerMovement>().big = true;
			}
			item_number = 0;
		}
		else if (item_number == 3 && !cloned) {
			Vector2 pos = new Vector2( mario_small.transform.position.x, mario_small.transform.position.y + 5.0f);
			// Vector2 pos = new Vector2( mario_small.transform.position.x + 1.0f, mario_small.transform.position.y);
			mario.gameObject.GetComponent<PlayerMovement>().original = false;
			Instantiate(mario, pos, mario_small.transform.rotation);
			item_number = 0;
			cloned = true;
		}
		if (type == PowerUp.none) {
			mario_tanooki.transform.position = holderPos;
			mario_big.transform.position = holderPos;
		}
		else if (type == PowerUp.mushroom) {
			mario_tanooki.transform.position = holderPos;
			mario_small.transform.position = holderPos;
		}
		else if (type == PowerUp.tanooki) {
			mario_big.transform.position = holderPos;
			mario_small.transform.position = holderPos;
			
		}
		timer += Time.fixedDeltaTime;
	}
}
