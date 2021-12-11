# coding=utf-8

from Capteur import *


class Carte(object):
    """
    :version: 1.0
    :author: Rasputin Team
    """
    """ ATTRIBUTES
    capteurs  (private)
    """

    def __init__(self, capteurs):
        """
        @param int capteurs :
        @return  :
        @author Rasputin Team
        """
        self.capteurs = [None] * capteurs

    def ajouterCapteur(self, capteur: Capteur, position: int):
        """
        @param Capteur capteur :
        @param int position :
        @return  :
        @author Rasputin Team
        """
        self.capteurs[position] = capteur

    def get(self, position):
        """
        @param int position :
        @return Capteur : from position
        @author Rasputin Team
        """
        return self.capteurs[position]
