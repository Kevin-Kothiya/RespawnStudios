
/// obj_Radar - Create Event

// Inherit interaction functionality
event_inherited();

image_xscale = 0.50;
image_yscale = 0.50;

interaction_label = "Talk to Radar";

// What happens when Vector presses E
on_interact = function()
{
    if (!instance_exists(obj_DialogueManager)
        || !instance_exists(obj_ObjectiveManager))
    {
        show_debug_message(
            "Dialogue or Objective Manager not found!"
        );
        return;
    }

    // Get current objective and gear progress
    var current_objective =
        obj_ObjectiveManager.objective_id;

    var gear_count =
        obj_ObjectiveManager.gears_collected;

    // Store the dialogue lines
    var dialogue_lines = [];

    switch (current_objective)
    {
        // FIRST CONVERSATION
        case "talk_radar":

            dialogue_lines = [
                "Vector! You're finally awake.",
                "Welcome to the Underground Refuge. We've been hiding from the humans.",
                "The resistance needs your help. We don't have much time.",
                "Before you head out, let's make sure you're prepared.",
                "Find five gears around the refuge and bring them back to me."
            ];

            break;


        // COLLECTING GEARS
        case "collect_gears":

            switch (gear_count)
            {
                case 0:
                    dialogue_lines = [
                        "You haven't found any gears yet, Vector?",
                        "Take a look around the refuge.",
                        "We need five gears before you can continue."
                    ];
                    break;

                case 1:
                    dialogue_lines = [
                        "One gear already! Good start, Vector.",
                        "We still need four more.",
                        "Keep searching the refuge."
                    ];
                    break;

                case 2:
                    dialogue_lines = [
                        "Two gears already! You're making progress.",
                        "Three more should be enough.",
                        "Keep it up, Vector!"
                    ];
                    break;

                case 3:
                    dialogue_lines = [
                        "Three gears! We're getting closer.",
                        "Just two more and we'll have what we need.",
                        "Check the other platforms."
                    ];
                    break;

                case 4:
                    dialogue_lines = [
                        "Four gears! Excellent work, Vector.",
                        "We only need one more.",
                        "Come back as soon as you find it!"
                    ];
                    break;

                default:
                    dialogue_lines = [
                        "Keep searching, Vector.",
                        "We need five gears in total."
                    ];
                    break;
            }

            break;


        // AFTER COLLECTING ALL FIVE GEARS
        case "return_radar":

            dialogue_lines = [
                "You're back, Vector! Did you find everything?",
                "Five gears! Excellent work.",
                "These should help us repair some of our equipment.",
                "You're ready for the next part of your mission.",
                "Head toward the exit. Be careful out there!"
            ];

            break;


        // EXIT UNLOCKED
        case "reach_exit":

            dialogue_lines = [
                "Everything is ready, Vector.",
                "Head to the exit when you're prepared.",
                "Good luck out there!"
            ];

            break;


        // TUTORIAL COMPLETED
        case "complete":

            dialogue_lines = [
                "Well done, Vector!",
                "The resistance is counting on you."
            ];

            break;
    }

    // Start the selected dialogue
    if (array_length(dialogue_lines) > 0)
    {
        with (obj_DialogueManager)
        {
            start_dialogue("Radar", dialogue_lines);
        }
    }

    // Only these conversations advance objectives
    if (current_objective == "talk_radar"
        || current_objective == "return_radar")
    {
        with (obj_ObjectiveManager)
        {
            waiting_for_radar_dialogue = true;
            radar_dialogue_seen_open = false;
        }
    }
};
