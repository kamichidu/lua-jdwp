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
local prototype= require 'prototype'
local bitwise= require 'bitwise'
local socket= require 'socket'
local jdwp= require 'jdwp'

local client= prototype {
    default= prototype.assignment_copy,
}

client.__protocol= {
    [jdwp.VirtualMachine._]= {
        [jdwp.VirtualMachine.Version]= {
            encode= function(self, data)
                return nil
            end,
            decode= function(self, response, bytes)
                response.description= self:_parse_string(bytes)
                response.jdwpMajour= self:_parse_int(bytes)
                response.jdwpMinor= self:_parse_int(bytes)
                response.vmVersion= self:_parse_string(bytes)
                response.vmName= self:_parse_string(bytes)

                return response
            end,
        },
        [jdwp.VirtualMachine.ClassesBySignature]= {
            encode= function(self, data)
                return self:_encode_string(data.signature)
            end,
            decode= function(self, response, bytes)
                local nclasses= self:_parse_int(bytes)

                response.classes= {}
                for _= 1, nclasses do
                    local class= {}
                    class.refTypeTag= self:_parse_byte(bytes)
                    class.typeID= self:_parse_referenceTypeID(bytes)
                    class.status= self:_parse_int(bytes)
                    table.insert(response.classes, class)
                end

                return response
            end,
        },
        [jdwp.VirtualMachine.AllClasses]= {
            encode= function(self, data)
                return nil
            end,
            decode= function(self, response, bytes)
                local nclasses= self:_parse_int(bytes)

                response.classes= {}
                for _= 1, nclasses do
                    local class= {}
                    class.refTypeTag= self:_parse_byte(bytes)
                    class.typeID= self:_parse_referenceTypeID(bytes)
                    class.signature= self:_parse_string(bytes)
                    class.status= self:_parse_int(bytes)
                    table.insert(response.classes, class)
                end

                return response
            end,
        },
        [jdwp.VirtualMachine.AllThreads]= {
            encode= function(self, data)
                return nil
            end,
            decode= function(self, response, bytes)
                local nthreads= self:_parse_int(bytes)

                response.threads= {}
                for _= 1, nthreads do
                    local thread= {}
                    thread.thread= self:_parse_threadID(bytes)
                    table.insert(response.threads, thread)
                end

                return response
            end,
        },
        [jdwp.VirtualMachine.TopLevelThreadGroups]= {
            encode= function(self, data)
                return nil
            end,
            decode= function(self, response, bytes)
                local ngroups= self:_parse_int(bytes)

                response.groups= {}
                for _= 1, ngroups do
                    local group= {}
                    group.group= self:_parse_threadGroupID(bytes)
                    table.insert(response.groups, group)
                end

                return response
            end,
        },
        [jdwp.VirtualMachine.Dispose]= {
            encode= function(self, data)
                return nil
            end,
            decode= function(self, response, bytes)
                return nil
            end,
        },
        [jdwp.VirtualMachine.IDSizes]= {
            encode= function(self, data)
                return nil
            end,
            decode= function(self, response, bytes)
                response.fieldIDSize= self:_parse_int(bytes)
                response.methodIDSize= self:_parse_int(bytes)
                response.objectIDSize= self:_parse_int(bytes)
                response.referenceTypeIDSize= self:_parse_int(bytes)
                response.frameIDSize= self:_parse_int(bytes)

                return response
            end,
        },
        [jdwp.VirtualMachine.Suspend]= {
            encode= function(self, data)
                return nil
            end,
            decode= function(self, response, bytes)
                return nil
            end,
        },
        [jdwp.VirtualMachine.Resume]= {
            encode= function(self, data)
                return nil
            end,
            decode= function(self, response, bytes)
                return nil
            end,
        },
        [jdwp.VirtualMachine.Exit]= {
            encode= function(self, data)
                return self:_encode_int(data.exitCode)
            end,
            decode= function(self, response, bytes)
                return nil
            end,
        },
        [jdwp.VirtualMachine.CreateString]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.Capabilities]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.ClassPaths]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.DisposeObjects]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.HoldEvents]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.ReleaseEvents]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.CapabilitiesNew]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.RedefineClasses]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.SetDefaultStratum]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.AllClassesWithGeneric]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.VirtualMachine.InstanceCounts]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.ReferenceType._]= {
        [jdwp.ReferenceType.Signature]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.ClassLoader]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.Modifiers]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.Fields]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.Methods]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.GetValues]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.SourceFile]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.NestedTypes]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.Status]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.Interfaces]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.ClassObject]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.SourceDebugExtension]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.SignatureWithGeneric]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.FieldsWithGeneric]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.MethodsWithGeneric]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.Instances]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.ClassFileVersion]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ReferenceType.ConstantPool]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.ClassType._]= {
        [jdwp.ClassType.Superclass]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ClassType.SetValues]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ClassType.InvokeMethod]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ClassType.NewInstance]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.ArrayType._]= {
        [jdwp.ArrayType.NewInstance]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.InterfaceType._]= {
    },
    [jdwp.Method._]= {
        [jdwp.Method.LineTable]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.Method.VariableTable]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.Method.Bytecodes]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.Method.IsObsolete]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.Method.VariableTableWithGeneric]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.Field._]= {
    },
    [jdwp.ObjectReference._]= {
        [jdwp.ObjectReference.ReferenceType]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ObjectReference.GetValues]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ObjectReference.SetValues]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ObjectReference.MonitorInfo]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ObjectReference.InvokeMethod]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ObjectReference.DisableCollection]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ObjectReference.EnableCollection]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ObjectReference.IsCollected]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ObjectReference.ReferringObjects]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.StringReference._]= {
        [jdwp.StringReference.Value]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.ThreadReference._]= {
        [jdwp.ThreadReference.Name]= {
            encode= function(self, data)
                return self:_encode_threadID(data.thread)
            end,
            decode= function(self, response, bytes)
                response.threadName= self:_parse_string(bytes)

                return response
            end,
        },
        [jdwp.ThreadReference.Suspend]= {
            encode= function(self, data)
                return self:_encode_threadID(data.thread)
            end,
            decode= function(self, response, bytes)
                return response
            end,
        },
        [jdwp.ThreadReference.Resume]= {
            encode= function(self, data)
                return self:_encode_threadID(data.thread)
            end,
            decode= function(self, response, bytes)
                return response
            end,
        },
        [jdwp.ThreadReference.Status]= {
            encode= function(self, data)
                return self:_encode_threadID(data.thread)
            end,
            decode= function(self, response, bytes)
                response.threadStatus= self:_parse_int(bytes)
                response.suspendStatus= self:_parse_int(bytes)

                return response
            end,
        },
        [jdwp.ThreadReference.ThreadGroup]= {
            encode= function(self, data)
                return self:_encode_threadID(data.thread)
            end,
            decode= function(self, response, bytes)
                response.group= self:_parse_threadGroupID(bytes)

                return response
            end,
        },
        [jdwp.ThreadReference.Frames]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadReference.FrameCount]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadReference.OwnedMonitors]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadReference.CurrentContendedMonitor]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadReference.Stop]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadReference.Interrupt]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadReference.SuspendCount]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadReference.OwnedMonitorsStackDepthInfo]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadReference.ForceEarlyReturn]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.ThreadGroupReference._]= {
        [jdwp.ThreadGroupReference.Name]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadGroupReference.Parent]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ThreadGroupReference.Children]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.ArrayReference._]= {
        [jdwp.ArrayReference.Length]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ArrayReference.GetValues]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.ArrayReference.SetValues]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.ClassLoaderReference._]= {
        [jdwp.ClassLoaderReference.VisibleClasses]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.EventRequest._]= {
        [jdwp.EventRequest.Set]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.EventRequest.Clear]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.EventRequest.ClearAllBreakpoints]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.StackFrame._]= {
        [jdwp.StackFrame.GetValues]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.StackFrame.SetValues]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.StackFrame.ThisObject]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
        [jdwp.StackFrame.PopFrames]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.ClassObjectReference._]= {
        [jdwp.ClassObjectReference.ReflectedType]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
    [jdwp.Event._]= {
        [jdwp.Event.Composite]= {
            encode= function(self, data)
                -- TODO
            end,
            decode= function(self, response, bytes)
                -- TODO
            end,
        },
    },
}

function client:connect(host, port)
    self.__socket= socket.tcp()
    self.__host= host
    self.__port= port

    local data, msg= self.__socket:connect(self.__host, self.__port)
    if not data then
        return nil, msg
    end

    -- jdwp handshake
    local jdwp_word= 'JDWP-Handshake'
    self.__socket:send(jdwp_word)

    local data, msg= self.__socket:receive(jdwp_word:len())
    if not data then
        return nil, msg
    elseif data ~= jdwp_word then
        return nil, 'Failed jdwp handshake.'
    end

    -- determine some id sizes in bytes
    local data, msg= self:call(jdwp.VirtualMachine, jdwp.VirtualMachine.IDSizes)
    if not data then
        return nil, msg
    end
    self.__idsizes= data

    return true
end

function client:call(command_set, command, data)
    self:_send(30, 0x00, command_set, command, data)

    local response, msg= self:_receive(30)
    if not response then
        return nil, msg
    end

    local bytes= response.bytes
    response.bytes= nil
    return self.__protocol[command_set._][command].decode(self, response, bytes)
end

function client:close()
    self.__socket:close()
end

function client:_send(id, flags, command_set, command, data)
    local packet= {}

    -- length - 4 bytes
    table.insert(packet, string.char(0x00))
    table.insert(packet, string.char(0x00))
    table.insert(packet, string.char(0x00))
    table.insert(packet, string.char(0x00))
    -- id - 4 bytes
    table.insert(packet, string.char(bitwise.rshift(bitwise.band(id, 0xff000000), 24)))
    table.insert(packet, string.char(bitwise.rshift(bitwise.band(id, 0x00ff0000), 16)))
    table.insert(packet, string.char(bitwise.rshift(bitwise.band(id, 0x0000ff00),  8)))
    table.insert(packet, string.char(bitwise.rshift(bitwise.band(id, 0x000000ff),  0)))
    -- flags - 1 byte
    table.insert(packet, string.char(0x00))
    -- command set - 1 byte
    table.insert(packet, string.char(command_set._))
    -- command - 1 byte
    table.insert(packet, string.char(command))
    -- data - variadic length
    if data then
        for _, byte in ipairs(self.__protocol[command_set._][command].encode(self, data) or {}) do
            table.insert(packet, string.char(byte))
        end
    end

    packet[1]= string.char(bitwise.rshift(bitwise.band(#packet, 0xff000000), 24))
    packet[2]= string.char(bitwise.rshift(bitwise.band(#packet, 0x00ff0000), 16))
    packet[3]= string.char(bitwise.rshift(bitwise.band(#packet, 0x0000ff00),  8))
    packet[4]= string.char(bitwise.rshift(bitwise.band(#packet, 0x000000ff),  0))

    self.__socket:send(table.concat(packet, ''))
end

function client:_receive(id)
    -- local bytes= io.open('bytes', 'w')
    -- -- local chars= io.open('chars', 'w')
    -- while true do
    --     local char= self.__socket:receive(1)
    --     bytes:write(char)
    --     bytes:flush()
    --     -- chars:write()
    -- end
    -- bytes:close()
    -- -- chars:close()

    local response, msg= self.__socket:receive(4)
    if not response then
        return nil, msg
    end

    local bytes= {}
    for c in response:gmatch('.') do
        table.insert(bytes, string.byte(c))
    end
    local length= self:_parse_int(bytes)

    local response, msg= self.__socket:receive(length - 4)
    if not response then
        return nil, msg
    end

    local bytes= {}
    for c in response:gmatch('.') do
        table.insert(bytes, string.byte(c))
    end

    local data= {}
    -- length - 4 bytes
    data.length= length
    -- id - 4 bytes
    data.id= self:_parse_int(bytes)
    -- flags - 1 byte
    data.flags= self:_parse_byte(bytes)
    -- error_code - 2 bytes
    data.error_code= self:_parse_short(bytes)
    -- rest
    data.bytes= bytes

    -- 0x80 is a indicator of reply packet
    if data.id == id and bitwise.btest(data.flags, 0x80) then
        return data
    else
        return self:_receive(id)
    end
end

function client:_encode_byte(data)
    return {bitwise.band(data, 0xff)}
end

function client:_parse_byte(data)
    return table.remove(data, 1)
end

function client:_encode_boolean(data)
    if data ~= 0 then
        return {0x01}
    else
        return {0x00}
    end
end

function client:_parse_boolean(data)
    local value= table.remove(data, 1)
    if value == 0 then
        return false
    else
        return true
    end
end

function client:_encode_short(data)
    return {
        bitwise.rshift(bitwise.band(data, 0xff00), 8),
        bitwise.rshift(bitwise.band(data, 0x00ff), 0),
    }
end

function client:_parse_short(data)
    local value= 0
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 8))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 0))
    return value
end

function client:_encode_int(data)
    return {
        bitwise.rshift(bitwise.band(data, 0xff000000), 24),
        bitwise.rshift(bitwise.band(data, 0x00ff0000), 16),
        bitwise.rshift(bitwise.band(data, 0x0000ff00), 8),
        bitwise.rshift(bitwise.band(data, 0x000000ff), 0),
    }
end

function client:_parse_int(data)
    local value= 0
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 24))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 16))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 8))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 0))
    return value
end

function client:_encode_long(data)
    return {
        bitwise.rshift(bitwise.band(data, 0xff00), 56),
        bitwise.rshift(bitwise.band(data, 0xff00), 48),
        bitwise.rshift(bitwise.band(data, 0xff00), 40),
        bitwise.rshift(bitwise.band(data, 0xff00), 32),
        bitwise.rshift(bitwise.band(data, 0xff00), 24),
        bitwise.rshift(bitwise.band(data, 0xff00), 16),
        bitwise.rshift(bitwise.band(data, 0xff00), 8),
        bitwise.rshift(bitwise.band(data, 0x00ff), 0),
    }
end

function client:_parse_long(data)
    local value= 0
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 56))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 48))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 40))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 32))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 24))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 16))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 8))
    value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), 0))
    return value
end

function client:_encode_objectID(data)
    local nbytes= self.__idsizes.objectIDSize
    local bitmask= 0xff
    local bytes= {}
    for ibytes= 1, nbytes do
        local shiftbits= (nbytes - ibytes) * 8
        table.insert(bytes, bitwise.rshift(bitwise.band(data, bitwise.lshift(bitmask, shiftbits)), shiftbits))
    end
    return bytes
end

function client:_parse_objectID(data)
    local nbytes= self.__idsizes.objectIDSize
    local value= 0
    for ibytes= 1, nbytes do
        local shiftbits= (nbytes - ibytes) * 8
        value= bitwise.bor(value, bitwise.lshift(table.remove(data, 1), shiftbits))
    end
    return value
end

function client:_encode_tagged_objectID(data)
end

function client:_parse_tagged_objectID(data)
end

function client:_encode_threadID(data)
    return self:_encode_objectID(data)
end

function client:_parse_threadID(data)
    return self:_parse_objectID(data)
end

function client:_encode_threadGroupID(data)
    return self:_encode_objectID(data)
end

function client:_parse_threadGroupID(data)
    return self:_parse_objectID(data)
end

function client:_encode_stringID(data)
    return self:_encode_objectID(data)
end

function client:_parse_stringID(data)
    return self:_parse_objectID(data)
end

function client:_encode_classLoaderID(data)
    return self:_encode_objectID(data)
end

function client:_parse_classLoaderID(data)
    return self:_parse_objectID(data)
end

function client:_encode_classObjectID(data)
    return self:_encode_objectID(data)
end

function client:_parse_classObjectID(data)
    return self:_parse_objectID(data)
end

function client:_encode_arrayID(data)
    return self:_encode_objectID(data)
end

function client:_parse_arrayID(data)
    return self:_parse_objectID(data)
end

function client:_encode_referenceTypeID(data)
    return self:_encode_objectID(data)
end

function client:_parse_referenceTypeID(data)
    return self:_parse_objectID(data)
end

function client:_encode_classID(data)
    return self:_encode_referenceTypeID(data)
end

function client:_parse_classID(data)
    return self:_parse_referenceTypeID(data)
end

function client:_encode_interfaceID(data)
    return self:_encode_referenceTypeID(data)
end

function client:_parse_interfaceID(data)
    return self:_parse_referenceTypeID(data)
end

function client:_encode_arrayTypeID(data)
    return self:_encode_referenceTypeID(data)
end

function client:_parse_arrayTypeID(data)
    return self:_parse_referenceTypeID(data)
end

function client:_encode_methodID(data)
end

function client:_parse_methodID(data)
end

function client:_encode_fieldID(data)
end

function client:_parse_fieldID(data)
end

function client:_encode_frameID(data)
end

function client:_parse_frameID(data)
end

function client:_encode_location(data)
end

function client:_parse_location(data)
end

function client:_encode_string(data)
    local bytes= {}
    for _, v in ipairs(self:_encode_int(data:len())) do
        table.insert(bytes, v)
    end
    for c in data:gmatch('.') do
        table.insert(bytes, string.byte(c))
    end
    return bytes
end

function client:_parse_string(data)
    local length= self:_parse_int(data)
    local chars= {}
    for _= 1, length do
        local char= table.remove(data, 1)
        table.insert(chars, string.char(char))
    end
    return table.concat(chars, '')
end

function client:_encode_value(data)
end

function client:_parse_value(data)
end

function client:_encode_untagged_value(data)
end

function client:_parse_untagged_value(data)
end

function client:_encode_arrayregion(data)
end

function client:_parse_arrayregion(data)
end

return client
