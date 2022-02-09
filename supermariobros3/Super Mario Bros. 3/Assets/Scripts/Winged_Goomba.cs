using UnityEngine;
using System.Collections;

public class Winged_Goomba : Enemy_AI {
	public int counter = 0;
	public float timer = 0f;

	public override void Start() {
		base.Start();
	}

	// Update is called once per frame
	public override void Update () {
		if (timer > 0) {
			timer -= Time.deltaTime;
			base.Update();
			return;
		}

		Vector2 point1 = new Vector2(is_on_ground.transform.position.x - is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y - is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		Vector2 point2 = new Vector2(is_on_ground.transform.position.x + is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y + is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		canJump = Physics2D.OverlapArea(point1, point2, GroundLayers, 0, 0);

		if (canJump && !dead) {
			anim.SetBool("Jump", false);

			if (counter < 3) {
				anim.SetBool("Jump", true);
				vel.y = 5.0f;
				counter++;
			}
			else if (counter == 3) {
				anim.SetBool("Jump", true);
				vel.y = 9.0f;
				counter = 0;
				timer = .8f;
			}
			transform.position = new Vector3(transform.position.x, transform.position.y + .04f, transform.position.z);

			return;
		}



		base.Update ();
	}

}
