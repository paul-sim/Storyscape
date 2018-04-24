EXTERNAL playSfx(sfx)
EXTERNAL playMusic(music)

// # wait3sec
// {playSfx("getting up")}

-> Intro
// -> FirstTimeMainJunction

=== Intro
* [\[pull yourself up\]]
    // # wait1sec
    - Sharp, centralized pain in the back of the head.
    ** [continue]
    - Lazer-like ringing between the ears. A dull, bobbing sensation.
    ** [continue]
        *** [\[try to remember\]] 
        - Nothing registers.
        *** [\[think\]]
        - Trying. It only hurts.
        *** [continue]
    - Got to wake up. Need to get help.
    ** [continue]
    /*- Try to stand straight. Plant the feet. Strengthen the legs.
    ** [continue] */
    - Head up. Breathe.
    ** [continue]
    // # wait1sec
    - Slowly, the senses come online.
    ** [\[look around\]]
-> FirstTimeMainJunction
    
// Someone's left the light on. 
// punch the drywall, reveal a secret key
//A stench. An apprehensive feeling.

-> DONE

=== FirstTimeMainJunction
- Enclosed in a small room. Never seen this place.
A wooden desk in plain sight.
+ [\[approach the wooden desk\]] -> WoodenDeskTop
+ [\[turn right\]] -> MainJunctionEast
+ [\[turn left\]] -> MainJunctionSouth
-> DONE


/*** main junctions. main loop ***/
=== MainJunctionNorth
- A wooden desk in plain sight.
+ [\[approach the wooden desk\]] -> WoodenDeskTop
+ [\[turn right\]] -> MainJunctionEast
+ [\[turn left\]] -> MainJunctionSouth
-> DONE

=== MainJunctionEast
- A door and a keypad.
+ [\[try keypad\]] -> Keypad
+ [\[turn right\]] -> MainJunctionSouth
+ [\[turn left\]] -> MainJunctionNorth

=== MainJunctionSouth
- A dull hanging stench. A white wall.
+ [\[examine the wall\]] -> WallExamine
+ [\[turn right\]] -> MainJunctionNorth
+ [\[turn left\]] -> MainJunctionEast
-> DONE
/*** end of main junctions ***/


/*** north junction ***/
=== WoodenDeskTop
- A handwritten note rests on the desk's surface.
+ [\[read the note\]] -> ReadNote
+ [\[search the drawers\]] -> InsideDrawers
+ [\[step back\]] -> MainJunctionNorth
-> DONE

=== ReadNote
- "It's odd. When I was a child, I thought I could do everything.
    I had dreams.
    I had goals."
+ [continue]
- "Then I grew up, and only a few things mattered.
    I loved my family. I still do."
+ [continue]
- "And for that, I must do what's best for them."
+ [continue]
-> WoodenDeskTop
-> DONE

=== InsideDrawers
- "A remote for a light switch. A bottle of painkillers." <>
* [pick up remote] -> remote_option
+ [examine bottle of painkillers] -> ExaminePainkillers
+ [close drawer] -> WoodenDeskTop 
-> DONE

=== remote_option
-> InsideDrawers
-> DONE

=== ExaminePainkillers
- A high dosage. Bottle is empty.
+ [continue]
-> InsideDrawers
-> DONE
/*** end of north junction ***/


/*** south junction ***/
=== WallExamine
- A repulsive odor from the wall. So much stronger now.
+ [\[step back\]] -> MainJunctionSouth
* {remote_option} [\[Kill lights with remote\]] -> WallMessage
-> DONE

=== WallMessage
// # hit_lights
- A bright glowy message plastered on the wall.
* [continue]
- "I do this with love.
    Let's set sail together."
* [continue]
- A flash of fleeting memory.
* [continue]
# wait1sec
- A boy.
    A girl.
    A look of terror on their faces.
* [continue]
- Another flashback.
* [continue]
# wait1sec
- The code. 3142.
* [continue]
- An overwhelming feeling of apprehension.
    Must leave this place.
* [step back] -> MainJunctionSouth
-> DONE
/*** end of south junction ***/


/*** east junction ***/
=== Keypad
-
+ [1] -> KeypadWrong
+ [2] -> KeypadWrong
+ [3] -> KeypadCorrect1
+ [4] -> KeypadWrong
+ [step back] ->MainJunctionEast
-> DONE

=== KeypadCorrect1
-
+ [1] -> KeypadCorrect2
+ [2] -> KeypadWrong
+ [3] -> KeypadWrong
+ [4] -> KeypadWrong
+ [step back] ->MainJunctionEast
-> DONE

=== KeypadCorrect2
-
+ [1] -> KeypadWrong
+ [2] -> KeypadWrong
+ [3] -> KeypadWrong
+ [4] -> KeypadCorrect3
+ [step back] ->MainJunctionEast
-> DONE

=== KeypadCorrect3
-
+ [1] -> KeypadWrong
+ [2] -> KeypadCorrect4
+ [3] -> KeypadWrong
+ [4] -> KeypadWrong
+ [step back] ->MainJunctionEast
-> DONE

=== KeypadWrong
-
+ [1] -> KeypadWrong
+ [2] -> KeypadWrong
+ [3] -> KeypadWrong
+ [4] -> KeypadWrong
+ [step back] ->MainJunctionEast
-> DONE

=== KeypadCorrect4
- A subtle clicking noise.
    The door swings open.
* [continue]
- So dark. Pitch black in the connected space.
* [continue]
- A feeling I will wake from this.
    I wish I could just sleep.
* [continue]
# wait1sec
-
* [\[walk through door\]]
-> DONE

/*** end of east junction ***/


