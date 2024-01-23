extends Node2D

# export array of AnimatedSprite2D, one for each character
@export_group("Characters Settings")

@export_subgroup("Character1Attributes")
@export var char1AnimatedSprite: AnimatedSprite2D = null
@export var char1CollisionShape2D: CollisionPolygon2D = null

@export_subgroup("Character2Attributes")
@export var char2AnimatedSprite: AnimatedSprite2D = null
@export var char2CollisionShape2D: CollisionPolygon2D = null

@export_subgroup("CharacterNodes")
@export var char1: Node2D = null
@export var char2: Node2D = null
@export var charBoth: Node2D = null

var is_separated: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
    # move the characters attributes to charBoth node
    merge_charactors()
    return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    # trigger by input
    if Input.is_action_just_pressed("player_power_separate"):
        on_separate_charactors()
        
    # test code
    test_move_charactor()
    return

"""
--------------------------------------------------
    test function (moving the characters)
--------------------------------------------------
"""
func test_move_charactor():
    """
        Behavior:
            test for moving the character, check if the characters are separated or not
                If the characters are separated:
                    Move each char1 and char2 separately 
                If the characters are not separated:
                    Move the charBoth
        Args:
            None
        Returns:
            None
    """
    if is_separated:
        char1.velocity.x = 10
        char1.move_and_slide()
        char2.move_and_slide()
    else:
        charBoth.velocity.y = 10
        charBoth.move_and_slide()
    return
    
"""
--------------------------------------------------
    Event for the character separation
--------------------------------------------------
"""

func on_separate_charactors():
    """
        Behavior:
            On Event: change the parent from charBoth to char1 and char2
            **Once this func called, the trigger 'is_separated' will be set to true**
        Args:
            None
        Returns:
            None
    """
    if not is_separated:
        is_separated = true
        separate_charactors_logic()
    return

"""
--------------------------------------------------
    Functions for the character separation
--------------------------------------------------
"""
func separate_charactors_logic():
    """
        Behavior:
            separate the characters from each other
        Args:
            None
        Returns:
            None
    """
    # save the velocity and position
    var v = charBoth.velocity
    var p = charBoth.position
    
    # separate the characters
    separate_charactors()
    # remove the charBoth node
    remove_node(charBoth)
    # change the parent of each characters to the root node
    change_parent(char1, self)
    change_parent(char2, self)

    # maintain the velocity and position
    char1.velocity = v
    char2.velocity = v
    char1.position = p
    char2.position = p
    return

"""
--------------------------------------------------
    utilize func for the character seperation
--------------------------------------------------
"""
func merge_charactors():
    """
        Behavior:
            Merge the characters into one
        Args:
            None
        Returns:
            None
    """
    change_char_attribute_parent(char1AnimatedSprite, char1CollisionShape2D, charBoth)
    change_char_attribute_parent(char2AnimatedSprite, char2CollisionShape2D, charBoth)
    return

func separate_charactors():
    """
        Behavior:
            separate the characters from each other
        Args:
            None
        Returns:
            None
    """
    change_char_attribute_parent(char1AnimatedSprite, char1CollisionShape2D, char1)
    change_char_attribute_parent(char2AnimatedSprite, char2CollisionShape2D, char2)
    return

func change_char_attribute_parent(charAnimation: AnimatedSprite2D, charCollisionShape: CollisionPolygon2D, targetParent: Node2D):
    """
        Behavior:
            Remove the character from its parent and add it to the new parent
        Args:
            charNode (Node2D): The character node to change the parent
            charAnimation (AnimatedSprite2D): The character animation to change the parent
            charCollisionShape (CollisionPolygon2D): The character collision shape to change the parent
            parent (Node2D): The new parent
        Returns:    
            None
    """
    change_parent(charAnimation, targetParent)
    change_parent(charCollisionShape, targetParent)
    return 

func change_parent(node: Node2D, parent: Node2D):
    """
        Behavior:
            Remove the node from its parent and add it to the new parent
        Args:
            node (Node2D): The node to change the parent
            parent (Node2D): The new parent
        Returns:    
            None
    """
    node.get_parent().remove_child(node)
    parent.add_child(node)
    return 

func remove_node(node: Node2D):
    """
        Behavior:
            Remove the node from its parent
        Args:
            node (Node2D): The node to remove
        Returns:
            None
    """
    node.get_parent().remove_child(node)
    return
