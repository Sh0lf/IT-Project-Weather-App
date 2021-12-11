# coding=utf-8

class Capteur(object):
    """
    :version: 1.0
    :author: Rasputin Team
    """

    """ ATTRIBUTES
  
    mesure  (private)
  
    id  (private)
  
    unite  (private)
  
    """

    def __init__(self, unites, id, mesure=0):
        """
        @param string unites :
        @param int id :
        @return  :
        @author Rasputin Team
        """
        self.unites = unites
        self.id = id
        self.mesure = mesure
        pass

    def setMesure(self, mesure):
        """
        @param float mesure :
        @return  :
        @author Rasputin Team
        """
        self.mesure = mesure

    def getId(self):
        """
        @return int : id
        @author Rasputin Team
        """
        return self.id

    def getMesure(self):
        """
        @return float : mesure
        @author Rasputin Team
        """
        return self.mesure

    def getUnites(self):
        """
        @return string : unites
        @author Rasputin Team
        """
        return self.unites
