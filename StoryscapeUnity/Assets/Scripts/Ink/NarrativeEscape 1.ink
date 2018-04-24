EXTERNAL playSfx(sfx)
EXTERNAL playMusic(music)

// # wait3sec
// {playSfx("getting up")}

// -> Intro
-> FirstTimeMainJunction

=== Intro
* [\[pull yourself up\]]
    // # wait3sec
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
    // # wait3sec
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
* [\[approach the wooden desk\]] -> WoodenDeskTop
* [\[turn left\]] -> MainJunctionWest
* [\[turn right\]] -> MainJunctionEast
-> DONE


/*** main junctions. main loop ***/
=== MainJunctionNorth
- A wooden desk in plain sight.
+ [\[approach the wooden desk\]] -> WoodenDeskTop
+ [\[turn left\]] -> MainJunctionWest
+ [\[turn right\]] -> MainJunctionEast
-> DONE

=== MainJunctionEast
- A dull hanging stench. A white wall.
* [\[step forward\]]
* [\[turn left\]] -> MainJunctionNorth
* [\[turn right\]] -> MainJunctionSouth
-> DONE

=== MainJunctionSouth
- A pile of worn clothes. A door.
* [\[pick up clothes\]]
* [\[try door\]] // get insert key option later
* [\[turn left\]] -> MainJunctionEast
* [\[turn right\]] -> MainJunctionWest
-> DONE

=== MainJunctionWest
- An opened sports bag.
* [\[search the bag\]]
* [\[turn left\]] -> MainJunctionSouth
* [\[turn right\]] -> MainJunctionNorth
-> DONE
/*** end of main junctions ***/


/*** north junction ***/
=== WoodenDeskTop
- A handwritten note rests on the desk's surface.
+ [\[read the note\]] -> ReadNote
+ [\[search the drawers\]] -> MainJunctionSouth
+ [\[step back\]] -> MainJunctionNorth
-> DONE

=== ReadNote
- "It's odd. When I was a child, I thought I could do everything.
    I had dreams.
    I had goals."
* [continue]
- "Then I grew up, and only a few things mattered.
    Early on, it was my career. Then it was my family."
* [continue]
- "Now it's a search for truth.
    What is the meaning of all this.
    I'm sorry, but I have to do this."
-> WoodenDeskTop
-> DONE
/*** end of north junction ***/



