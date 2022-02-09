using UnityEngine;
using System.Collections;

public class PlayerMovement : MonoBehaviour {
	public LayerMask GroundLayers;
	public AudioClip JumpSound;
	public AudioClip TurnSound;
	public AudioClip RunSound;
	public AudioClip HitSound;
	public GUIText RunMeter;
	public bool canJump;
	public bool canJump2;
	private Animator mario_anim;
	private Transform is_on_ground;
	public Transform tail;
	public float timer = 10.0f;
	public float tailtimer = 10.0f;
	public float runtimer = 0;
	public int runmeter = 0;
	public float velAtTakeOff = 0;
	private float normalHeight = 0;
	public bool HitJump = false;
	public bool Hit = false;
	public bool turn = false;
	public bool run = false;
	public bool big = false;
	public bool hover = false;
	public float pauseEndTime;
	public BoxCollider2D coll;
	private GameObject mainCamera;
	public AudioClip tanooki_attack;
	public bool original;
	public bool CanClimb;
	void playSound(AudioClip sound, float vol){
		GetComponent<AudioSource>().clip = sound;
		GetComponent<AudioSource>().volume = vol;
		GetComponent<AudioSource>().Play();
	}

	void Awake () {
		CameraFollow.character = this.gameObject;
	}
	// Use this for initialization
	void Start () {
		RunMeter = GameObject.Find("RunMeter").GetComponent<GUIText>() as GUIText;
		mario_anim = GetComponent<Animator>();
		is_on_ground = transform.FindChild("IsOnGround");
		mainCamera = GameObject.Find ("Main Camera");
		if (mainCamera.GetComponent<Health>().tanooki) {

			tail = transform.FindChild("Tail");
			tail.gameObject.SetActive(false);
		}
		runtimer = Time.realtimeSinceStartup + 0.2f;
		coll = this.transform.GetComponent<BoxCollider2D>() as BoxCollider2D;
		normalHeight = coll.size.y;
	}
	// Update is called once per frame
	void Update () {
		if (transform == null)
			return;
		if (is_on_ground == null)
			return;
		if (run && runmeter < 7 && runtimer < Time.realtimeSinceStartup && !turn && 
		    (Input.GetButton("Left") || Input.GetButton("Right")) && Mathf.Abs(GetComponent<PE_Obj2D>().vel.x) >= 3.0f) {
			runmeter++;
			runtimer = Time.realtimeSinceStartup + 0.2f;
		}
		else if (((!run || turn || (Mathf.Abs(GetComponent<PE_Obj2D>().vel.x) < 3.0f )) && runmeter > 0 && runtimer < Time.realtimeSinceStartup)) {
			if (GetComponent<AudioSource>().clip == RunSound && GetComponent<AudioSource>().isPlaying)
				GetComponent<AudioSource>().Stop ();
			runmeter--;
			runtimer = Time.realtimeSinceStartup + 0.4f;
		}
		mario_anim.speed = Mathf.Abs (GetComponent<PE_Obj2D>().vel.x) * 0.1f + 0.5f;
		Vector2 point1 = new Vector2(is_on_ground.transform.position.x - is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y - is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		Vector2 point2 = new Vector2(is_on_ground.transform.position.x + is_on_ground.GetComponent<Collider2D>().bounds.size.x/2, 
		                             is_on_ground.transform.position.y + is_on_ground.GetComponent<Collider2D>().bounds.size.y/2);
		canJump = Physics2D.OverlapArea(point1, point2, GroundLayers, 0, 0);
		// next bool needed so that you can't jump off walls
		canJump2 = Physics2D.OverlapPoint(is_on_ground.position, GroundLayers);
		if (Input.GetAxis ("Vertical") == 1 && CanClimb) {
			mario_anim.SetBool("Climb", true);
			Vector2 pos = new Vector2(transform.position.x, transform.position.y + 0.1f);
			transform.position = pos;
			GetComponent<PE_Obj2D>().vel.y = 0;
			GetComponent<PE_Obj2D>().vel.x = 0;
			GetComponent<PE_Obj2D>().acc.y = 0;
		}
		else if (Input.GetAxis ("Vertical") == -1 && CanClimb) {
			mario_anim.SetBool("Climb", true);
			Vector2 pos = new Vector2(transform.position.x, transform.position.y - 0.1f);
			transform.position = pos;
			GetComponent<PE_Obj2D>().vel.y = 0;
			GetComponent<PE_Obj2D>().vel.x = 0;
			GetComponent<PE_Obj2D>().acc.y = 0;
		}
		else if ((Input.GetAxis ("Vertical") == -1) && big &&
		    ((Input.GetButton ("Left") && Input.GetButton ("Right")) || ( !Input.GetButton ("Left") && !Input.GetButton ("Right")))) {
			mario_anim.SetBool("Crouch",true);
			coll.size = new Vector2(coll.size.x, normalHeight*0.67f);
		}
		else if (big) {
			mario_anim.SetBool("Crouch",false);
			coll.size = new Vector2(coll.size.x, normalHeight);
		}
		if (Input.GetButtonDown ("Run") && mainCamera.GetComponent<Health>().tanooki) {
			tailtimer = 0;
			playSound (tanooki_attack, 0.7f);
			mario_anim.SetBool("Attack", true);
			// mario_anim.SetBool("Attack", false);
		}
		else if ((Input.GetButton ("Run") || Input.GetButtonUp ("Run")) && mainCamera.GetComponent<Health>().tanooki) {
			mario_anim.SetBool("Attack", false);
		}
		if (!CanClimb) {
			mario_anim.SetBool("Climb", false);
		}
		if (mainCamera.GetComponent<Health>().tanooki) {
			if (tailtimer >= 0.05f && tailtimer <= 0.35f) {
				Vector3 parentPos = tail.parent.transform.position;
				float sign = Mathf.Sign (tail.parent.localScale.x);

				tail.position = new Vector3(parentPos.x + (sign *.91f), parentPos.y - .49f, parentPos.z);
				tail.gameObject.SetActive(true);
			}
			else {
				tail.gameObject.SetActive(false);
			}
		}
		if (Input.GetButtonDown ("Run")) {
			runtimer = Time.realtimeSinceStartup + 0.2f;
		}
		if (Input.GetButtonUp ("Run")) {
			runtimer = Time.realtimeSinceStartup + 0.4f;
		}
		if (Input.GetButton ("Run") && canJump2 && (Input.GetButton ("Left") || Input.GetButton("Right"))) {
			run = true;
		}
		else {
			run = false;
		}

		mario_anim.SetFloat("Speed", Mathf.Abs(GetComponent<PE_Obj2D>().vel.x));
		// decelerate if you're holding both right and left buttons
		if (Input.GetButton("Right") && Input.GetButton("Left") && canJump) {
			GetComponent<PE_Obj2D>().acc.x = -GetComponent<PE_Obj2D>().vel.x * 4.0f;
			run = false;
			turn = false;
			mario_anim.SetBool ("Turn", turn);
			mario_anim.SetBool ("Run", run);
		}
		else if (Input.GetButton ("Right")) {
			transform.localScale = new Vector3(1, 1, 1);
			if (GetComponent<PE_Obj2D>().vel.x < -0.1f) {
				if (canJump)
					turn = true;
				transform.localScale = new Vector3(-1, 1, 1);
				GetComponent<PE_Obj2D>().acc.x = 20.0f;
			}
			else if (canJump) {
				turn = false;
				transform.localScale = new Vector3(1, 1, 1);
				GetComponent<PE_Obj2D>().acc.x = 6.0f + 4.0f * runmeter;
			}
			else {
				GetComponent<PE_Obj2D>().acc.x = 6.0f;
			}
			
			mario_anim.SetBool ("Turn", turn);
		}
		else if (Input.GetButton ("Left")) {
			transform.localScale = new Vector3(-1, 1, 1);
			if (GetComponent<PE_Obj2D>().vel.x > 0.1f) {
				if (canJump)
					turn = true;
				transform.localScale = new Vector3(1, 1, 1);
				GetComponent<PE_Obj2D>().acc.x = -20.0f;
			}
			else if (canJump){
				turn = false;
				transform.localScale = new Vector3(-1, 1, 1);
				GetComponent<PE_Obj2D>().acc.x = -6.0f - 4.0f * runmeter;
			}
			else {
				GetComponent<PE_Obj2D>().acc.x = -6.0f;
			}
			mario_anim.SetBool ("Turn", turn);
		}
		else {
			turn = false;
			mario_anim.SetBool ("Turn", turn);
			if ((GetComponent<PE_Obj2D>().vel.x < -0.01f) || (GetComponent<PE_Obj2D>().vel.x > 0.01f)) {
				if (Mathf.Abs(GetComponent<PE_Obj2D>().vel.x) < 5.0f)
					GetComponent<PE_Obj2D>().acc.x = -GetComponent<PE_Obj2D>().vel.x * 4.0f;		
				else
					GetComponent<PE_Obj2D>().acc.x = -Mathf.Sign(GetComponent<PE_Obj2D>().vel.x) * 15.0f;
			}
		}
		if (turn) {
			if (GetComponent<AudioSource>().isPlaying && GetComponent<AudioSource>().clip == RunSound) {
				GetComponent<AudioSource>().Stop ();
			}
			if (!GetComponent<AudioSource>().isPlaying)
				playSound(TurnSound, 1.0f);
		}
		else {
			if (GetComponent<AudioSource>().isPlaying && GetComponent<AudioSource>().clip == TurnSound)
				GetComponent<AudioSource>().Stop();
		}
		// terminal velocities in x-direction
		if ((Mathf.Abs (GetComponent<PE_Obj2D>().vel.x - 5.0f) <= 0.5f) && Input.GetButton ("Right")
		    && !Input.GetButton("Left") && !run) {
			GetComponent<PE_Obj2D>().vel.x = 5.0f;
			GetComponent<PE_Obj2D>().acc.x = 0;
		}
		else if ((GetComponent<PE_Obj2D>().vel.x >= 5.0f) && Input.GetButton ("Right") && !run && canJump2) {
			GetComponent<PE_Obj2D>().acc.x = -GetComponent<PE_Obj2D>().vel.x * 1.0f;
		} 
		if ((Mathf.Abs (GetComponent<PE_Obj2D>().vel.x + 5.0f) <= 0.5f) && Input.GetButton ("Left") 
		    && !Input.GetButton("Right") && !run) {
			GetComponent<PE_Obj2D>().vel.x = -5.0f;
			GetComponent<PE_Obj2D>().acc.x = 0;
		}
		// slow down gradually to walking speed if you were running and let go of the run button
		else if ((GetComponent<PE_Obj2D>().vel.x <= -5.0f) && Input.GetButton("Left") && !run && canJump2){
			GetComponent<PE_Obj2D>().acc.x = -GetComponent<PE_Obj2D>().vel.x * 1.0f;
		}
		if ((GetComponent<PE_Obj2D>().vel.x >= 9.0f) && Input.GetButton ("Right") && run && runmeter != 7) {
			mario_anim.SetBool ("Run", false);
			GetComponent<PE_Obj2D>().vel.x = 9.0f;
			GetComponent<PE_Obj2D>().acc.x = 0;
		}
		else if ((GetComponent<PE_Obj2D>().vel.x <= -9.0f) && Input.GetButton("Left") && run && runmeter != 7){
			mario_anim.SetBool ("Run", false);
			GetComponent<PE_Obj2D>().vel.x = -9.0f;
			GetComponent<PE_Obj2D>().acc.x = 0;
		}
		else if ((GetComponent<PE_Obj2D>().vel.x >= 9.0f) && Input.GetButton ("Right") && run && runmeter == 7) {
			if (!GetComponent<AudioSource>().isPlaying && canJump)
				playSound(RunSound, 1.0f);
			mario_anim.SetBool ("Run", true);
			GetComponent<PE_Obj2D>().vel.x = 11.0f;
			GetComponent<PE_Obj2D>().acc.x = 0;
		}
		else if ((GetComponent<PE_Obj2D>().vel.x <= -9.0f) && Input.GetButton("Left") && run && runmeter == 7){
			if (!GetComponent<AudioSource>().isPlaying && canJump)
				playSound(RunSound, 1.0f);
			mario_anim.SetBool ("Run", true);
			GetComponent<PE_Obj2D>().vel.x = -11.0f;
			GetComponent<PE_Obj2D>().acc.x = 0;
		}
		else {
			mario_anim.SetBool ("Run", false);
		}
		if (Mathf.Abs(GetComponent<PE_Obj2D>().vel.x) >= 11.0f) {
			GetComponent<PE_Obj2D>().vel.x = Mathf.Sign(GetComponent<PE_Obj2D>().vel.x) * 11.0f;
		}
//		if (Mathf.Abs (GetComponent<PE_Obj2D>().vel.x) >= 11.0f && !turn) {
//			GetComponent<PE_Obj2D>().vel.x = Mathf.Sign (GetComponent<PE_Obj2D>().vel.x) * 11.0f;
//			GetComponent<PE_Obj2D>().acc.x = 0;
//		}
//		if (((Mathf.Abs (GetComponent<PE_Obj2D>().vel.x) < 12.0f) || (GetComponent<PE_Obj2D>().acc.y != 0)) && (audio.clip == RunSound)){
//			audio.Stop();
//		}
		canJump2 = Mathf.Abs (GetComponent<PE_Obj2D>().acc.y) < 0.1f && (canJump2 || canJump);
//		if (Input.GetButtonDown ("Jump") && mainCamera.GetComponent<Health>().tanooki && !canJump2) {
//			pauseEndTime = Time.realtimeSinceStartup + 2.0f;
//			GetComponent<PE_Obj2D>().vel.y = -2.0f;
//			GetComponent<PE_Obj2D>().acc.y = 0;
//			hover = true;
//		}

		if (Input.GetButtonDown ("Jump")) {
			if (CanClimb) {
				mario_anim.SetBool("Climb", false);
			}
			if ((canJump) && (canJump2)){
				GetComponent<PE_Obj2D>().vel.y = 10.0f;
				if (GetComponent<AudioSource>().isPlaying) {
					GetComponent<AudioSource>().Stop ();
				}
				playSound (JumpSound, 1.0f);
				// audio.Play();
				//audio.PlayOneShot(JumpSound, 1.0f);
				timer = 0;
				velAtTakeOff = GetComponent<PE_Obj2D>().vel.x;
				canJump = false;
				canJump2 = false;
			}
			else if (mainCamera.GetComponent<Health>().tanooki && ((Mathf.Abs(velAtTakeOff) < 11.0f) || (runmeter < 6))) {
				mario_anim.SetBool("Hover",true);
				mario_anim.SetBool("Fly",false);
				GetComponent<AudioSource>().clip = tanooki_attack;
				if (GetComponent<AudioSource>().clip == tanooki_attack && !GetComponent<AudioSource>().isPlaying)
					playSound (tanooki_attack, 0.7f);
				pauseEndTime = Time.realtimeSinceStartup + 15.0f * Time.fixedDeltaTime;
				GetComponent<PE_Obj2D>().vel.y = -2.0f;
				GetComponent<PE_Obj2D>().acc.y = 0;
				hover = true;
			}
			else if (mainCamera.GetComponent<Health>().tanooki && (Mathf.Abs(velAtTakeOff) == 11.0f)) {
				mario_anim.SetBool("Fly",true);
				mario_anim.SetBool("Hover",true);
				GetComponent<AudioSource>().clip = tanooki_attack;
				if (GetComponent<AudioSource>().clip == tanooki_attack && !GetComponent<AudioSource>().isPlaying)
					playSound (tanooki_attack, 0.7f);
				pauseEndTime = Time.realtimeSinceStartup + 15.0f * Time.fixedDeltaTime;
				GetComponent<PE_Obj2D>().vel.y = 5.0f;
				GetComponent<PE_Obj2D>().acc.y = 0;
				if (runmeter < 7)
					runmeter++;
				hover = true;
			}
			else if (mainCamera.GetComponent<Health>().tanooki) {
				mario_anim.SetBool("Fly",false);
				mario_anim.SetBool("Hover",false);
			}
		}
		if (HitJump || Hit) {
			GetComponent<PE_Obj2D>().vel.y = 10.0f;
			if (GetComponent<AudioSource>().isPlaying) {
				GetComponent<AudioSource>().Stop ();
			}
			playSound (HitSound, 1.0f);
			// audio.Play();
			//audio.PlayOneShot(JumpSound, 1.0f);
			timer = 0;
			velAtTakeOff = GetComponent<PE_Obj2D>().vel.x;
			canJump = false;
			canJump2 = false;
		}
		float jumpMultiplier;
		if (run)
			jumpMultiplier = 1.0f;
		else
			jumpMultiplier = 0;
		if (!canJump){
			if (Input.GetButton("Jump") || HitJump) {
				// only if you're going upwards and the timer just started can you slow down gravity
				// the faster you were running at takeoff, the longer you can slow down gravity
//				if ((GetComponent<PE_Obj2D>().vel.y > 0) && (timer < (0.5f + 0.001f * jumpMultiplier * Mathf.Pow (Mathf.Abs (velAtTakeOff), 10)))){
//					GetComponent<PE_Obj2D>().acc.y = -27.5f;
//				}
				if ((GetComponent<PE_Obj2D>().vel.y > 0) && (timer < (0.35f + 0.0005f * jumpMultiplier * Mathf.Pow (Mathf.Abs (velAtTakeOff), 2)))){
					GetComponent<PE_Obj2D>().acc.y = 0;
				}
				else if (!(mainCamera.GetComponent<Health>().tanooki && hover)) { // standard gravity
					GetComponent<PE_Obj2D>().acc.y = -60.0f;
				}
				else if ((((Time.realtimeSinceStartup > pauseEndTime) && hover) || canJump2) && mainCamera.GetComponent<Health>().tanooki) {
					hover = false;
					GetComponent<PE_Obj2D>().acc.y = -60.0f;
				}
			}
			else if (!(mainCamera.GetComponent<Health>().tanooki && hover)) { // standard gravity
				GetComponent<PE_Obj2D>().acc.y = -60.0f;
			}
			else if (((Time.realtimeSinceStartup > pauseEndTime) && hover) && mainCamera.GetComponent<Health>().tanooki) {
				hover = false;
				mario_anim.SetBool("Hover",hover);
				GetComponent<PE_Obj2D>().acc.y = -60.0f;
			}
			// terminal velocity
			if (GetComponent<PE_Obj2D>().vel.y <= -15.0f) {
				GetComponent<PE_Obj2D>().acc.y = 0;
				GetComponent<PE_Obj2D>().vel.y = -15.0f;
			}
		}
		if (canJump2 && mainCamera.GetComponent<Health>().tanooki) {
			hover = false;
			mario_anim.SetBool("Hover",hover);
		}
		if (Input.GetButtonUp("Jump") && !mainCamera.GetComponent<Health>().tanooki) { // return to normal gravity if you let go of the jump button
			GetComponent<PE_Obj2D>().acc.y = -60.0f;
		}
		mario_anim.SetBool ("CanJump", canJump2 && GetComponent<PE_Obj2D>().vel.y == 0);
		if (turn && Input.GetButton ("Right") && !canJump2) {
			transform.localScale = new Vector3(1, 1, 1);
		}
		if (turn && Input.GetButton ("Left") && !canJump2) {
			transform.localScale = new Vector3(-1, 1, 1);
		}
		timer += Time.deltaTime;
		tailtimer += Time.fixedDeltaTime;
		HitJump = false;
		Hit = false;

		if (this.gameObject.transform.position.y <= mainCamera.transform.position.y - 12) {
			mainCamera.GetComponent<Health>().felloff = true;
		}
		if (original)
			RunMeter.text = "Run Meter: " + runmeter;
	}
}
