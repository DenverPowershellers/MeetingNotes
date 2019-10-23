# If direct access to classes are needed in the calling scope
#using module .\Person\person.psd1

# If direct access to classes is not needed but they are abstracted via functions
Import-Module .\Person\person.psd1 -Verbose

$a = [person]::new('Carrie','Underwood','01/01/1900')

$b = New-Person -FirstName 'Bob' -LastName 'Saget' -DateOfBirth '01/01/1900'