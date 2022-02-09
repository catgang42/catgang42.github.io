using UnityEngine;
using System.Collections;

public class Winged_koopa : Enemy_AI {

	public override void Start ()
	{
		base.Start ();
	}

	// Update is called once per frame
	public override void Update () {
		Vector2 point1 = new Vector2(is_on_ground.transform.position.x - is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y - is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		Vector2 point2 = new Vector2(is_on_ground.transform.position.x + is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y + is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		canJump = Physics2D.OverlapArea(point1, point2, GroundLayers, 0, 0);

		if (canJump && !dead) {
			vel.y = 12.0f;
		}

		base.Update ();
	}
	
}
