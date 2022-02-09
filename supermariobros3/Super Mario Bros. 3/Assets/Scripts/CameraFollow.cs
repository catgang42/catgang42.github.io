using UnityEngine;
using System.Collections;

public class CameraFollow : MonoBehaviour {
	public static GameObject character;
	public GameObject mario_small;
	public GameObject mario_big;
	public GameObject mario_tanooki;
	public float bound;
	public bool right_bound = false;
	public  bool left_bound = false;
	public float camera_ground; //lowest legal position of camera

	// Use this for initialization
	void Start () {

	}
	
	// Update is called once per frame
	void Update () {
		float dist = character.transform.position.x - this.transform.position.x;
		float vertdist = character.transform.position.y - this.transform.position.y;
		if (GetComponent<Health>().type == PowerUp.none) {
			character = mario_small;
		}
		else if (GetComponent<Health>().type == PowerUp.mushroom) {
			character = mario_big;
		}
		else if (GetComponent<Health>().type == PowerUp.tanooki) {
			character = mario_tanooki;
		}
		if (dist > bound){
			if (!right_bound) {
				Vector3 pos = new Vector3(character.transform.position.x - bound, this.transform.position.y, -10);
				this.transform.position = pos;
			}
		} else if (dist < -bound) {
			if (!left_bound) {
				Vector3 pos = new Vector3(character.transform.position.x + bound, this.transform.position.y, -10);
				this.transform.position = pos;
			}
		}
		if (vertdist > bound) {
			Vector3 pos = new Vector3(this.transform.position.x, character.transform.position.y - bound, -10);
			if (character.transform.position.y - bound < camera_ground) {
				pos = new Vector3(this.transform.position.x, camera_ground, -10);
			}
			this.transform.position = pos;
		}
		else if (vertdist < -bound) {
			Vector3 pos = new Vector3(this.transform.position.x, character.transform.position.y + bound, -10);
//			if (character.transform.position.y + bound > 12.79f) {
//				pos = new Vector3(this.transform.position.x, 12.79f, -10);
//			}

			if (pos.y < camera_ground) {
				pos.y = camera_ground;
			}
			this.transform.position = pos;
		}
	}
}

