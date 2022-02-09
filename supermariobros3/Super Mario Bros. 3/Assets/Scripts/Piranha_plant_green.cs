using UnityEngine;
using System.Collections;

public enum Piranha_state_green {
	MOVING_UP,
	MOVING_DOWN,
	WAITING,
	INACTIVE
}

public class Piranha_plant_green : MonoBehaviour {
	public float fireball_speed;
	public GameObject fireball;
	public bool player_seen;
	private float start_pos;
	public Piranha_state_green state;
	private float timer;
	public Transform player_pos;
	private bool direction; // true for right, false for left
	private Animator anim;
	private bool shot = false;
	// Use this for initialization
	void Start () {
		start_pos = transform.position.y;
		transform.position = new Vector3(transform.position.x, start_pos - 2, transform.position.z);
		state = Piranha_state_green.INACTIVE;
		anim = GetComponent<Animator>();
		direction = false;
	}
	
	// Update is called once per frame
	void Update() {
		if (state == Piranha_state_green.INACTIVE || state == Piranha_state_green.WAITING)
			return;

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

	void FixedUpdate () {
		Vector3 newPos;
		switch (state) {
		case Piranha_state_green.INACTIVE:
			if (player_seen) {
				state = Piranha_state_green.MOVING_UP;
			}

			break;

		case Piranha_state_green.MOVING_UP:

			newPos = new Vector3(transform.position.x, transform.position.y + .08f, transform.position.z);
			if (newPos.y >= start_pos) {
				newPos.y = start_pos;
				state = Piranha_state_green.WAITING;
				shot = false;
				timer = 1.6f;
			}
			transform.position = newPos;

			break;

		

		case Piranha_state_green.MOVING_DOWN:
			
			newPos = new Vector3(transform.position.x, transform.position.y - .08f, transform.position.z);
			if (newPos.y <= start_pos - 2) {
				newPos.y = start_pos - 2;

				if (player_seen) {
					state = Piranha_state_green.WAITING;
					timer = 1.6f;
				}
				else {
					state = Piranha_state_green.INACTIVE;
				}
			}
			transform.position = newPos;
			
			break;

		case Piranha_state_green.WAITING: 
			if (timer <= 0.0f)
				state = Piranha_state_green.MOVING_UP;

			timer -= Time.fixedDeltaTime;
			break;
		}
	}

	void OnTriggerEnter2D(Collider2D other) {
		if (other.gameObject.tag == "Player") {
			GameObject mainCamera = GameObject.Find ("Main Camera");
			mainCamera.GetComponent<Health>().gothurt = true;
		}
		else if (other.gameObject.tag == "Tail") {
			float thisHeight = GetComponent<BoxCollider2D>().bounds.size.y;
			float topOfPipe = start_pos - thisHeight + .2f;
			if (transform.position.y + thisHeight > topOfPipe && other.transform.position.y + other.bounds.size.y > topOfPipe) {
				Destroy (gameObject);
			}
		}
	}
}
