require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmAbilities()
    local obj = GUI.fromHandle(_obj_newObject("form"));
    local self = obj;
    local sheet = nil;

    rawset(obj, "_oldSetNodeObjectFunction", rawget(obj, "setNodeObject"));

    function obj:setNodeObject(nodeObject)
        sheet = nodeObject;
        self.sheet = nodeObject;
        self:_oldSetNodeObjectFunction(nodeObject);
    end;

    function obj:setNodeDatabase(nodeObject)
        self:setNodeObject(nodeObject);
    end;

    _gui_assignInitialParentForForm(obj.handle);
    obj:beginUpdate();
    obj:setName("frmAbilities");
    obj:setWidth(910);
    obj:setHeight(65);
    obj:setMargins({top=2});

    obj.rectangle1 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle1:setParent(obj);
    obj.rectangle1:setAlign("client");
    obj.rectangle1:setColor("#212121");
    obj.rectangle1:setName("rectangle1");

    obj.textEditor1 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor1:setParent(obj.rectangle1);
    obj.textEditor1:setLeft(0);
    obj.textEditor1:setTop(0);
    obj.textEditor1:setWidth(685);
    obj.textEditor1:setHeight(65);
    obj.textEditor1:setField("habilidade");
    obj.textEditor1:setName("textEditor1");

    obj.textEditor2 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor2:setParent(obj.rectangle1);
    obj.textEditor2:setLeft(685);
    obj.textEditor2:setTop(0);
    obj.textEditor2:setWidth(75);
    obj.textEditor2:setHeight(65);
    obj.textEditor2:setField("dificuldade");
    obj.textEditor2:setName("textEditor2");

    obj.textEditor3 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor3:setParent(obj.rectangle1);
    obj.textEditor3:setLeft(760);
    obj.textEditor3:setTop(0);
    obj.textEditor3:setWidth(75);
    obj.textEditor3:setHeight(65);
    obj.textEditor3:setField("custo");
    obj.textEditor3:setName("textEditor3");

    obj.edit1 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit1:setParent(obj.rectangle1);
    obj.edit1:setLeft(835);
    obj.edit1:setTop(0);
    obj.edit1:setWidth(50);
    obj.edit1:setHeight(65);
    obj.edit1:setField("nivel");
    obj.edit1:setType("number");
    obj.edit1:setFontSize(20);
    obj.edit1:setHorzTextAlign("center");
    obj.edit1:setVertTextAlign("center");
    obj.edit1:setMax(3);
    obj.edit1:setName("edit1");

    obj.dataLink1 = GUI.fromHandle(_obj_newObject("dataLink"));
    obj.dataLink1:setParent(obj.rectangle1);
    obj.dataLink1:setFields({'nivel'});
    obj.dataLink1:setName("dataLink1");

    obj._e_event0 = obj.dataLink1:addEventListener("onChange",
        function (_, field, oldValue, newValue)
            if sheet==nil then return end;
            
            				local node = NDB.getRoot(sheet);
            				local objetos = NDB.getChildNodes(node.listaDeHabilidades);
            				local nivel = 0;
            
            				for i=1, #objetos, 1 do 
            					nivel = nivel + (tonumber(objetos[i].nivel) or 0);
            				end;
            
            				node.habilidadesNivel = nivel;
        end, obj);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event0);
    end;

    obj._oldLFMDestroy = obj.destroy;

    function obj:destroy() 
        self:_releaseEvents();

        if (self.handle ~= 0) and (self.setNodeDatabase ~= nil) then
          self:setNodeDatabase(nil);
        end;

        if self.dataLink1 ~= nil then self.dataLink1:destroy(); self.dataLink1 = nil; end;
        if self.rectangle1 ~= nil then self.rectangle1:destroy(); self.rectangle1 = nil; end;
        if self.edit1 ~= nil then self.edit1:destroy(); self.edit1 = nil; end;
        if self.textEditor2 ~= nil then self.textEditor2:destroy(); self.textEditor2 = nil; end;
        if self.textEditor1 ~= nil then self.textEditor1:destroy(); self.textEditor1 = nil; end;
        if self.textEditor3 ~= nil then self.textEditor3:destroy(); self.textEditor3 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmAbilities()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmAbilities();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmAbilities = {
    newEditor = newfrmAbilities, 
    new = newfrmAbilities, 
    name = "frmAbilities", 
    dataType = "", 
    formType = "undefined", 
    formComponentName = "form", 
    title = "", 
    description=""};

frmAbilities = _frmAbilities;
Firecast.registrarForm(_frmAbilities);

return _frmAbilities;
