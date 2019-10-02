* Explain object-oriented programming
  * Classes are blueprints
  * Objects are instantiated from classes
  * Everything in PS is an object
* Build a simple class (01-Basics\01-simple.ps1)
  * Simple structure w/ a few properties
  * Add a constructor
  * Introduce access modifiers
    * Public (implied) vs Hidden
    * Static
  * Add a method
    * Return type
    * Static [string] DoSomething ([int ]$Parameter)
* Extend a class
  * Overwrite methods
  * Touch on overloads, signatures

* Import from ps1 works with Import-Module
* Import from module requires 'using module modulename' if class needs to be exposed
  * If class doesn't need to be exposed, it needs to be wrapped in functions