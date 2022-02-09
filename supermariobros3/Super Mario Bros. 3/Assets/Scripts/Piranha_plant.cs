using UnityEngine;
using System.Collections;

public enum Piranha_state {
	MOVING_UP,
	MOVING_DOWN,
	SHOOTING,
	WAITING,
	INACTIVE
}

public class Piranha_plant : MonoBehaviour {
	public float fireball_speed;
	public GameObject fireball;
	public bool player_seen;
	private float start_pos;
	public Piranha_state state;
	private float timer;
	public Transform player_pos;
	private bool direction; // true for right, false for left
	private Animator anim;
	private bool shot = false;
	public bool fire;
	// Use this for initialization
	void Start () {
		start_pos = transform.position.y;
		if (fire)
			transform.position = new Vector3(transform.position.x, start_pos - 2.42f, transform.position.z);
		else
			transform.position = new Vector3(transform.position.x, start_pos - 2, transform.position.z);
		state = Piranha_state.INACTIVE;
		anim = GetComponent<Animator>();
		direction = false;
	}
	
	// Update is called once per frame
	void Update() {
		if (state == Piranha_state.INACTIVE || state == Piranha_state.WAITING)
			return;
		if (fire) {
			if (player_pos.position.x > this.transform.position.x && direction == false) {
				transform.localScale = new Vector3(-1, 1, 1);
				direction = true;
			}
			else if (player_pos.position.x < this.transform.position.x && direction == true) {
				transform.localScale = new Vector3(1, 1, 1);
				direction = false;
			}

			if (player_pos.position.y > this.transform.position.y + 1) {
				anim.SetBool("look_up", true);
			} else {
				anim.SetBool("look_up", false);
			}
		}
	}

	void FixedUpdate () {
		Vector3 newPos;
		switch (state) {
		case Piranha_state.INACTIVE:
			if (player_seen) {
				state = Piranha_state.MOVING_UP;
			}

			break;

		case Piranha_state.MOVING_UP:

			newPos = new Vector3(transform.position.x, transform.position.y + .08f, transform.position.z);
			if (newPos.y >= start_pos) {
				newPos.y = start_pos;
				state = Piranha_state.SHOOTING;
				shot = false;
				timer = 1.6f;
			}
			transform.position = newPos;

			break;

		case Piranha_state.SHOOTING:
			if (timer < .6f && !shot && fire) {

				Vector3 fireball_pos = transform.position;
				fireball_pos.y += .5f;
				GameObject go = Instantiate(fireball, fireball_pos, Quaternion.identity) as GameObject;
				Vector3 dir = player_pos.transform.position - transform.position;
				dir.y -= .5f;
				if (dir.y > 0f) {
					if (3.5 * (dir.y + .5f) >= Mathf.Abs(dir.x)) { //45 degrees up
						dir.y = Mathf.Abs(dir.x);
					} else {
						dir.y = Mathf.Abs(dir.x) / 2.5f;
					}
				} else {
					if (Mathf.Abs(dir.y) > Mathf.Abs(dir.x)) {// 45 degrees down
						dir.y = -Mathf.Abs(dir.x) * .8f;
					} else {
						dir.y = -Mathf.Abs(dir.x) / 3f;
					}
				}

				dir.Normalize();
				dir *= fireball_speed;
				go.GetComponent<PE_Obj2D>().vel = dir;


				shot = true;
			}

			if (timer <= 0.0f) {
				state = Piranha_state.MOVING_DOWN;
			}

			timer -= Time.fixedDeltaTime;
			break;

		case Piranha_state.MOVING_DOWN:
			
			newPos = new Vector3(transform.position.x, transform.position.y - .08f, transform.position.z);

			if (((newPos.y <= start_pos - 2.42f) && fire) || ((newPos.y <= start_pos - 2) && !fire)){
				if (fire)
					newPos.y = start_pos - 2.42f;
				else
					newPos.y = start_pos - 2;
					
				if (player_seen) {
					state = Piranha_state.WAITING;
					timer = 1.6f;
				}
				else {
					state = Piranha_state.INACTIVE;
				}
			}
			transform.position = newPos;
			
			break;

		case Piranha_state.WAITING:
			if (!player_seen)
				state = Piranha_state.INACTIVE;
			if (timer <= 0.0f)
				state = Piranha_state.MOVING_UP;

			timer -= Time.fixedDeltaTime;
			break;
		}
	}

	void OnTriggerEnter2D(Collider2D other) {
		if (other.gameObject.tag == "Player") {
			GameObject mainCamera = GameObject.Find ("Main Camera");
			mainCamera.GetComponent<Health> ().gothurt = true;
		} else if (other.gameObject.tag == "Tail") {
			float thisHeight = GetComponent<BoxCollider2D>().bounds.size.y;
			float topOfPipe = start_pos - thisHeight + .2f;
			if (transform.position.y + thisHeight > topOfPipe && other.transform.position.y + other.bounds.size.y > topOfPipe) {
				Destroy (gameObject);
			}
		}

	}
}
