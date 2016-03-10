#!/usr/bin/python
# -*- utf: coding-8 -*-

"""
Plays the best jams and/or intro music
"""

# IMPORT STANDARD LIBRARIES
import os.path, sys
import random

# IMPORT LOCAL LIBRARIES
import pygame.mixer, pygame.time


MIXER = pygame.mixer
TIME = pygame.time


def play_sound(sound):
    #choose a desired audio format
    MIXER.init(11025) #raises exception on fail
    #load the sound    
    sound = MIXER.Sound(sound)
    #start playing
    channel = sound.play()
    #poll until finished
    while channel.get_busy(): #still playing
        # print ('  ...still going...')
        TIME.wait(1000)
    print ('...Finished')
# end play_sound


def main(filePath=None):
    """
    Play an audio file as a buffered sound sample. Meant to be a quick import option
    """
    try:
        os.environ['OPENING_MUSIC']
    except KeyError:
        os.environ['OPENING_MUSIC'] = "TRUE"  # REMOVE    

    if filePath is None:
        # attempt to load from the pipeline directory
        directory = os.environ['PIPELINE_PROJECT']
        soundDir = os.path.join(directory, "the_LATEST", 
                                           "latest_CONFIG",
                                           "conf_SOUNDS")

    if os.environ['OPENING_MUSIC'].upper() == "TRUE":
        project_main()
# end main


def project_main(soundDir):
    """
    The project-specific method for music/sounds
    """
    filesH = [os.path.join(soundDir, f) for f in os.listdir(soundDir) if f.endswith(".wav")]
    
    randNum = int(random.uniform(0,1) * (len(filesH) - 1))
    fileToPlay = filesH[randNum]
    print("Playing File: {f}".format(f=fileToPlay))
    play_sound(fileToPlay)
# end project_main


if __name__ == '__main__':
    main()