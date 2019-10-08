## PowerShell:
## @color[orange](Advanced Functions)

---

@snap[north-west]
### @color[orange](Functions) are...
@snapend

@snap[midpoint fragment]
@box[bg-blue rounded](A grouping of PowerShell statements that encapsulate a specific task.)
@snapend

Note:

- Break complex tasks down into managable chunks
- Reusable to reduce repeating code
- Make scripts easier to read and maintain
- Demo simple functions and discuss

---

@snap[north-west]
### How do you make functions @color[orange](advanced)?
@snapend

@ul
- Add the @color[orange]([CmdletBinding(&#41;]) attribute
- Add a @color[orange]([Parameter(&#41;]) attribute
@ulend

Note:

- CmdletBinding is the preferred best practice
- Show syntax existence for Common Parameters
- [OutputType()]
- gv "*Preference"
- Demo output streams

---

@snap[north-west]
### Input @color[orange](validation) attributes
@snapend

@ul[west span-40](false)
- [AllowNull(&#41;]
- [AllowEmptyString(&#41;]
- [AllowEmptyCollection(&#41;]
- [ValidateCount(&#41;]
- [ValidateLength(&#41;]
- [ValidatePattern(&#41;]
- [ValidateRange(&#41;]
@ulend

@ul[east span-40](false)
- [ValidateScript(&#41;]
- [ValidateSet(&#41;]
- [ValidateNotNull(&#41;]
- [ValidateNotNullOrEmpty(&#41;]
- [ValidateDrive(&#41;]
- [ValidateUserDrive(&#41;]
@ulend