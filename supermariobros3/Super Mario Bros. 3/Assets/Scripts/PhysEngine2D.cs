using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public enum PE_GravType2D {
	none,
	constant,
	planetary
}

public enum PE_Collider2D {
	aabb,
	incline
}

public class PhysEngine2D : MonoBehaviour {
	static public List<PE_Obj2D>	objs;

	public Vector2		gravity = new Vector2(0,-9.8f);

	// Use this for initialization
	void Awake() {
		objs = new List<PE_Obj2D>();
	}


	void FixedUpdate () {
		// Handle the timestep for each object
		float dt = Time.fixedDeltaTime;
		foreach (PE_Obj2D po in objs) {
			TimeStep(po, dt);
		}

		// Resolve collisions


		// Finalize positions
		foreach (PE_Obj2D po in objs) {
			if (po == null)
				continue;
			po.transform.position = po.pos1;
		}

	}


	public void TimeStep(PE_Obj2D po, float dt) {
		if (po.still) {
			po.pos0 = po.pos1 = po.transform.position;
			return;
		}
		if (po == null)
			return;
		// Velocity
		po.vel0 = po.vel;
		Vector2 tAcc = po.acc;
		switch (po.grav) {
		case PE_GravType2D.constant:
			tAcc += gravity;
			break;
		}
		po.vel += tAcc * dt;

		// Position
		po.pos1 = po.pos0 = po.transform.position;
		po.pos1 += po.vel * dt;

	}
}
