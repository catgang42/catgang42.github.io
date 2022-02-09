//using UnityEngine;
//using System.Collections;
//
//public class Health : MonoBehaviour {
//	public bool big = false;
//	public bool gothurt = false;
//	public bool felloff;
//	public int item_number = 0;
//	public GameObject mario_small;
//	public GameObject mario_big;
//	public Animator anim;
//	public float timer;
//	public bool invincible;
//	Vector2 position;
//	// Use this for initialization
//	void Start () {
//		mario_small = GameObject.Find ("Mario");
//		//Vector3 loc = new Vector3(-7.79f,-0.75f,0);
//		//Instantiate(mario_small, loc, Quaternion.identity);
//		//mario_big = GameObject.Find ("Mario_Big");
//		anim = mario_small.GetComponent<Animator>();
//		big = false;
//		//mario_big.active = false;
//		timer = 10.0f;
//	}
//	
//	// Update is called once per frame
//	void FixedUpdate () {
//		if ((timer > 3.0f) && invincible){
//			invincible = false;
//			gothurt = false;
//		}
//		if ((gothurt && !big && !invincible) || (felloff)){
//			gothurt = false;
//			// make mario die
//			// Time.timeScale = 0.001f;
//			float pauseEndTime = Time.realtimeSinceStartup + 0.5f;
//			anim.SetBool("Dead", true);
//			while (Time.realtimeSinceStartup < pauseEndTime) {}
//			// PhysEngine2D.objs.Remove(mario_small.GetComponent<PE_Obj2D>());
//			// Time.timeScale = 1;
//			Application.LoadLevel(Application.loadedLevel);
//		}
//		else if (gothurt && !invincible){
//			// make mario lose powerup
//			gothurt = false;
//			Time.timeScale = 0.001f;
//			float pauseEndTime = Time.realtimeSinceStartup + 0.1f;
//			// delete small mario and add big mario
//			Instantiate(mario_small, mario_big.transform.position, mario_big.transform.rotation);
//			//mario_small.active = true;
//			mario_small.transform.localScale = new Vector3 (mario_big.transform.localScale.x, mario_big.transform.localScale.y,
//			                                                mario_big.transform.localScale.z);
//			timer = 0;
//			invincible = true;
//			// PhysEngine2D.objs.Remove(mario_big.GetComponent<PE_Obj2D>());
//			Destroy (mario_big);
//			//mario_big.active = false;
//			anim = mario_small.GetComponent<Animator>();
//			anim.speed = 1.0f/Time.timeScale;
//			// play small to big mario animation
//			//anim.SetBool("Mushroom", true);
//			
//			//anim.SetBool("Mushroom", false);
//			while (Time.realtimeSinceStartup < pauseEndTime) {}
//			anim.speed = 1.0f;
//			Time.timeScale = 1;
//			big = false;
//			mario_small.GetComponent<PlayerMovement>().big = false;
//		}
//		// mushroom
//		if (item_number == 1) {
//			if (!big) {
//				// freeze time
//				Time.timeScale = 0.001f;
//				float pauseEndTime = Time.realtimeSinceStartup + 0.1f;
//				// delete small mario and add big mario
//				// mario_big.active = true;
//				Instantiate(mario_big, mario_small.transform.position, mario_small.transform.rotation);
//				mario_big.transform.localScale = new Vector3 (mario_small.transform.localScale.x, mario_small.transform.localScale.y,
//				                                              mario_small.transform.localScale.z);
//				// mario_small.active = false;
//				// PhysEngine2D.objs.Remove(mario_small.GetComponent<PE_Obj2D>());
//				Destroy (mario_small);
//				anim = mario_big.GetComponent<Animator>();
//				anim.speed = 1.0f/Time.timeScale;
//				// play small to big mario animation
//				//anim.SetBool("Mushroom", true);
//				
//				//anim.SetBool("Mushroom", false);
//				while (Time.realtimeSinceStartup < pauseEndTime) {}
//				anim.speed = 1.0f;
//				Time.timeScale = 1;
//				big = true;
//				mario_big.GetComponent<PlayerMovement>().big = true;
//			}
//			item_number = 0;
//		}
//	}
//}
