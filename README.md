jdwp
========================================================================================================================
Java Debug Wire Protocol (JDWP) implementation for lua.

Usage
------------------------------------------------------------------------------------------------------------------------
```lua
local jdwp= require 'jdwp'
local client= jdwp.connect('localhost', 8700)

local info= client:call(jdwp.VirtualMachine, jdwp.VirtualMachine.Version)

print('description', info.description)
print('jdwpMajor',   info.jdwpMajor)
print('jdwpMinor',   info.jdwpMinor)
print('vmVersion',   info.vmVersion)
print('vmName',      info.vmName)

client:close()
```

Dependency
------------------------------------------------------------------------------------------------------------------------
* [prototype](https://github.com/siffiejoe/lua-prototype/)
* [luasocket](https://github.com/diegonehab/luasocket/)
* [bitwise](https://github.com/kamichidu/lua-bitwise/)

Supported features
------------------------------------------------------------------------------------------------------------------------
* VirtualMachine
    * [x] Version
    * [x] ClassesBySignature
    * [x] AllClasses
    * [x] AllThreads
    * [x] TopLevelThreadGroups
    * [ ] Dispose
    * [x] IDSizes
    * [x] Suspend
    * [x] Resume
    * [x] Exit
    * [ ] CreateString
    * [ ] Capabilities
    * [ ] ClassPaths
    * [ ] DisposeObjects
    * [ ] HoldEvents
    * [ ] ReleaseEvents
    * [ ] CapabilitiesNew
    * [ ] RedefineClasses
    * [ ] SetDefaultStratum
    * [ ] AllClassesWithGeneric
    * [ ] InstanceCounts
* ReferenceType
    * [ ] Signature
    * [ ] ClassLoader
    * [ ] Modifiers
    * [ ] Fields
    * [ ] Methods
    * [ ] GetValues
    * [ ] SourceFile
    * [ ] NestedTypes
    * [ ] Status
    * [ ] Interfaces
    * [ ] ClassObject
    * [ ] SourceDebugExtension
    * [ ] SignatureWithGeneric
    * [ ] FieldsWithGeneric
    * [ ] MethodsWithGeneric
    * [ ] Instances
    * [ ] ClassFileVersion
    * [ ] ConstantPool
* ClassType
    * [ ] Superclass
    * [ ] SetValues
    * [ ] InvokeMethod
    * [ ] NewInstance
* ArrayType
    * [ ] NewInstance
* InterfaceType
* Method
    * [ ] LineTable
    * [ ] VariableTable
    * [ ] Bytecodes
    * [ ] IsObsolete
    * [ ] VariableTableWithGeneric
* Field
* ObjectReference
    * [ ] ReferenceType
    * [ ] GetValues
    * [ ] SetValues
    * [ ] MonitorInfo
    * [ ] InvokeMethod
    * [ ] DisableCollection
    * [ ] EnableCollection
    * [ ] IsCollected
    * [ ] ReferringObjects
* StringReference
    * [ ] Value
* ThreadReference
    * [x] Name
    * [ ] Suspend
    * [ ] Resume
    * [ ] Status
    * [ ] ThreadGroup
    * [ ] Frames
    * [ ] FrameCount
    * [ ] OwnedMonitors
    * [ ] CurrentContendedMonitor
    * [ ] Stop
    * [ ] Interrupt
    * [ ] SuspendCount
    * [ ] OwnedMonitorsStackDepthInfo
    * [ ] ForceEarlyReturn
* ThreadGroupReference
    * [ ] Name
    * [ ] Parent
    * [ ] Children
* ArrayReference
    * [ ] Length
    * [ ] GetValues
    * [ ] SetValues
* ClassLoaderReference
    * [ ] VisibleClasses
* EventRequest
    * [ ] Set
    * [ ] Clear
    * [ ] ClearAllBreakpoints
* StackFrame
    * [ ] GetValues
    * [ ] SetValues
    * [ ] ThisObject
    * [ ] PopFrames
* ClassObjectReference
    * [ ] ReflectedType
* Event
    * [ ] Composite

Licence
------------------------------------------------------------------------------------------------------------------------
The MIT License (MIT)

Copyright (c) 2014 kamichidu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
