-- The MIT License (MIT)
--
-- Copyright (c) 2014 kamichidu
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
local jdwp= {}

-- command set definition
jdwp.VirtualMachine= {
    _= 1, -- VirtualMachine command set
    Version               = 1,
    ClassesBySignature    = 2,
    AllClasses            = 3,
    AllThreads            = 4,
    TopLevelThreadGroups  = 5,
    Dispose               = 6,
    IDSizes               = 7,
    Suspend               = 8,
    Resume                = 9,
    Exit                  = 10,
    CreateString          = 11,
    Capabilities          = 12,
    ClassPaths            = 13,
    DisposeObjects        = 14,
    HoldEvents            = 15,
    ReleaseEvents         = 16,
    CapabilitiesNew       = 17,
    RedefineClasses       = 18,
    SetDefaultStratum     = 19,
    AllClassesWithGeneric = 20,
    InstanceCounts        = 21,
}
jdwp.ReferenceType= {
    _= 2,
    Signature= 1,
    ClassLoader= 2,
    Modifiers= 3,
    Fields= 4,
    Methods= 5,
    GetValues= 6,
    SourceFile= 7,
    NestedTypes= 8,
    Status= 9,
    Interfaces= 10,
    ClassObject= 11,
    SourceDebugExtension= 12,
    SignatureWithGeneric= 13,
    FieldsWithGeneric= 14,
    MethodsWithGeneric= 15,
    Instances= 16,
    ClassFileVersion= 17,
    ConstantPool= 18,
}
jdwp.ClassType= {
    _= 3,
    Superclass= 1,
    SetValues= 2,
    InvokeMethod= 3,
    NewInstance= 4,
}
jdwp.ArrayType= {
    _= 4,
    NewInstance= 1,
}
jdwp.InterfaceType= {
    _= 5,
}
jdwp.Method= {
    _= 6,
    LineTable= 1,
    VariableTable= 2,
    Bytecodes= 3,
    IsObsolete= 4,
    VariableTableWithGeneric= 5,
}
jdwp.Field= {
    _= 8,
}
jdwp.ObjectReference= {
    _= 9,
    ReferenceType= 1,
    GetValues= 2,
    SetValues= 3,
    MonitorInfo= 5,
    InvokeMethod= 6,
    DisableCollection= 7,
    EnableCollection= 8,
    IsCollected= 9,
    ReferringObjects= 10,
}
jdwp.StringReference= {
    _= 10,
    Value= 1,
}
jdwp.ThreadReference= {
    _= 11,
    Name= 1,
    Suspend= 2,
    Resume= 3,
    Status= 4,
    ThreadGroup= 5,
    Frames= 6,
    FrameCount= 7,
    OwnedMonitors= 8,
    CurrentContendedMonitor= 9,
    Stop= 10,
    Interrupt= 11,
    SuspendCount= 12,
    OwnedMonitorsStackDepthInfo= 13,
    ForceEarlyReturn= 14,
}
jdwp.ThreadGroupReference= {
    _= 12,
    Name= 1,
    Parent= 2,
    Children= 3,
}
jdwp.ArrayReference= {
    _= 13,
    Length= 1,
    GetValues= 2,
    SetValues= 3,
}
jdwp.ClassLoaderReference= {
    _= 14,
    VisibleClasses= 1,
}
jdwp.EventRequest= {
    _= 15,
    Set= 1,
    Clear= 2,
    ClearAllBreakpoints= 3,
}
jdwp.StackFrame= {
    _= 16,
    GetValues= 1,
    SetValues= 2,
    ThisObject= 3,
    PopFrames= 4,
}
jdwp.ClassObjectReference= {
    _= 17,
    ReflectedType= 1,
}
jdwp.Event= {
    _= 64,
    Composite= 100,
}

-- constants
jdwp.Error= {
    NONE                                    = 0,
    INVALID_THREAD                          = 10,
    INVALID_THREAD_GROUP                    = 11,
    INVALID_PRIORITY                        = 12,
    THREAD_NOT_SUSPENDED                    = 13,
    THREAD_SUSPENDED                        = 14,
    THREAD_NOT_ALIVE                        = 15,
    INVALID_OBJECT                          = 20,
    INVALID_CLASS                           = 21,
    CLASS_NOT_PREPARED                      = 22,
    INVALID_METHODID                        = 23,
    INVALID_LOCATION                        = 24,
    INVALID_FIELDID                         = 25,
    INVALID_FRAMEID                         = 30,
    NO_MORE_FRAMES                          = 31,
    OPAQUE_FRAME                            = 32,
    NOT_CURRENT_FRAME                       = 33,
    TYPE_MISMATCH                           = 34,
    INVALID_SLOT                            = 35,
    DUPLICATE                               = 40,
    NOT_FOUND                               = 41,
    INVALID_MONITOR                         = 50,
    NOT_MONITOR_OWNER                       = 51,
    INTERRUPT                               = 52,
    INVALID_CLASS_FORMAT                    = 60,
    CIRCULAR_CLASS_DEFINITION               = 61,
    FAILS_VERIFICATION                      = 62,
    ADD_METHOD_NOT_IMPLEMENTED              = 63,
    SCHEMA_CHANGE_NOT_IMPLEMENTED           = 64,
    INVALID_TYPESTATE                       = 65,
    HIERARCHY_CHANGE_NOT_IMPLEMENTED        = 66,
    DELETE_METHOD_NOT_IMPLEMENTED           = 67,
    UNSUPPORTED_VERSION                     = 68,
    NAMES_DONT_MATCH                        = 69,
    CLASS_MODIFIERS_CHANGE_NOT_IMPLEMENTED  = 70,
    METHOD_MODIFIERS_CHANGE_NOT_IMPLEMENTED = 71,
    NOT_IMPLEMENTED                         = 99,
    NULL_POINTER                            = 100,
    ABSENT_INFORMATION                      = 101,
    INVALID_EVENT_TYPE                      = 102,
    ILLEGAL_ARGUMENT                        = 103,
    OUT_OF_MEMORY                           = 110,
    ACCESS_DENIED                           = 111,
    VM_DEAD                                 = 112,
    INTERNAL                                = 113,
    UNATTACHED_THREAD                       = 115,
    INVALID_TAG                             = 500,
    ALREADY_INVOKING                        = 502,
    INVALID_INDEX                           = 503,
    INVALID_LENGTH                          = 504,
    INVALID_STRING                          = 506,
    INVALID_CLASS_LOADER                    = 507,
    INVALID_ARRAY                           = 508,
    TRANSPORT_LOAD                          = 509,
    TRANSPORT_INIT                          = 510,
    NATIVE_METHOD                           = 511,
    INVALID_COUNT                           = 512,
}
for k, v in pairs(jdwp.Error) do jdwp.Error[v]= k end
jdwp.EventKind= {
    SINGLE_STEP                   = 1,
    BREAKPOINT                    = 2,
    FRAME_POP                     = 3,
    EXCEPTION                     = 4,
    USER_DEFINED                  = 5,
    THREAD_START                  = 6,
    THREAD_DEATH                  = 7,
    -- THREAD_END                    = 7,
    CLASS_PREPARE                 = 8,
    CLASS_UNLOAD                  = 9,
    CLASS_LOAD                    = 10,
    FIELD_ACCESS                  = 20,
    FIELD_MODIFICATION            = 21,
    EXCEPTION_CATCH               = 30,
    METHOD_ENTRY                  = 40,
    METHOD_EXIT                   = 41,
    METHOD_EXIT_WITH_RETURN_VALUE = 42,
    MONITOR_CONTENDED_ENTER       = 43,
    MONITOR_CONTENDED_ENTERED     = 44,
    MONITOR_WAIT                  = 45,
    MONITOR_WAITED                = 46,
    VM_START                      = 90,
    -- VM_INIT                       = 90,
    VM_DEATH                      = 99,
    VM_DISCONNECTED               = 100,
}
for k, v in pairs(jdwp.EventKind) do jdwp.EventKind[v]= k end
jdwp.ThreadStatus= {
    ZOMBIE   = 0,
    RUNNING  = 1,
    SLEEPING = 2,
    MONITOR  = 3,
    WAIT     = 4,
}
for k, v in pairs(jdwp.ThreadStatus) do jdwp.ThreadStatus[v]= k end
jdwp.SuspendStatus= {
    SUSPEND_STATUS_SUSPENDED = 0x1,
}
for k, v in pairs(jdwp.SuspendStatus) do jdwp.SuspendStatus[v]= k end
jdwp.ClassStatus= {
    VERIFIED    = 1,
    PREPARED    = 2,
    INITIALIZED = 4,
    ERROR       = 8,
}
for k, v in pairs(jdwp.ClassStatus) do jdwp.ClassStatus[v]= k end
jdwp.TypeTag= {
    CLASS     = 1,
    INTERFACE = 2,
    ARRAY     = 3,
}
for k, v in pairs(jdwp.TypeTag) do jdwp.TypeTag[v]= k end
jdwp.Tag= {
    ARRAY        = 91,
    BYTE         = 66,
    CHAR         = 67,
    OBJECT       = 76,
    FLOAT        = 70,
    DOUBLE       = 68,
    INT          = 73,
    LONG         = 74,
    SHORT        = 83,
    VOID         = 86,
    BOOLEAN      = 90,
    STRING       = 115,
    THREAD       = 116,
    THREAD_GROUP = 103,
    CLASS_LOADER = 108,
    CLASS_OBJECT = 99,
}
for k, v in pairs(jdwp.Tag) do jdwp.Tag[v]= k end
jdwp.StepDepth= {
    INTO = 0,
    OVER = 1,
    OUT  = 2,
}
for k, v in pairs(jdwp.StepDepth) do jdwp.StepDepth[v]= k end
jdwp.StepSize= {
    MIN	 = 0,
    LINE = 1,
}
for k, v in pairs(jdwp.StepSize) do jdwp.StepSize[v]= k end
jdwp.SuspendPolicy= {
    NONE         = 0,
    EVENT_THREAD = 1,
    ALL          = 2,
}
for k, v in pairs(jdwp.SuspendPolicy) do jdwp.SuspendPolicy[v]= k end
jdwp.InvokeOptions= {
    INVOKE_SINGLE_THREADED = 0x01,
    INVOKE_NONVIRTUAL      = 0x02,
}
for k, v in pairs(jdwp.InvokeOptions) do jdwp.InvokeOptions[v]= k end

function jdwp.connect(host, port)
    local client= (require 'jdwp.client'):clone()

    client:connect(host, port)

    return client
end

return jdwp
