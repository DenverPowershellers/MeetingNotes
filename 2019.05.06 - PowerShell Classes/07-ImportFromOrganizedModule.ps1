# Examine structure of ProperModule. Note dot-sourcing into psm1

# Using statement won't expose classes in they are dot-sourced in the psm1
# using module .\ProperModule\ProperModule.psd1

# Still works if direct access to classes is not needed 
#Import-Module .\ProperModule\ProperModule.psd1 -Verbose

Get-PublicFunction