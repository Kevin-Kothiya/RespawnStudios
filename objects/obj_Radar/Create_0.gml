
/// obj_Radar - Create Event

// Inherit interaction functionality
event_inherited();

image_xscale = 0.50;
image_yscale = 0.50;

interaction_label = "Talk to Radar";

// Define what happens when E is pressed
on_interact = function()
{
    if (instance_exists(obj_DialogueManager))
    {
        with (obj_DialogueManager)
        {
            start_dialogue(
                "Radar",
                [
                    "Vector! You're finally awake.",
                    "Welcome to the Underground Refuge. We've been hiding from the humans.",
                    "The resistance needs your help. We don't have much time.",
                    "Before you head out, let's make sure you're prepared."
                ]
            );
        }
    }
    else
    {
        show_debug_message(
            "Dialogue manager not found!"
        );
    }
};
