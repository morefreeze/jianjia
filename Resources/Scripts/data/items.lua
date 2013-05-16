
-- װ����λ id
-- 1ͷ����2�·���3���ס�4������5Ь�ӡ�6��Ʒ

item_prefix = {
    {'ǿ����', change={}, scale={}, skill={}}, -- 1
}

items = {
    -- ���֣�  ����,
    {_'����',  req={ge={level=5}},  equip={pos=1, change={}, scale={hp_max=1.1}}, use=nil, skill=nil, prefix={}, txt=_'�������ɱ仯��С��˫���ؽ���'}, -- 1
    {_'��ʿ�̵�', equip={pos=1, change={}, scale={}}, use=nil, skill=nil, stack=nil, prefix={{0.1}, {1}}, txt=_'ֻ�����߲���ӵ�еĶ̵�!'}, -- 2
    {_'��������֮��',  txt=_'��ǰ����һ���ݴԡ���'}, -- 3
}

Items = Class()

-- �ڲ�����������id��ȡ��Ʒtable��������ı��������Ʒtable����ԭ�����ء�
--         ��ô����ԭ������ʱ��Ҫ��id����Ʒ����ʱ��ֱ�Ӵ���Ʒtable
function Items:_getitem(id_or_table)
    local _type = type(id_or_table)
    if _type == 'table' then
        return id_or_table
    elseif _type == 'number' then
        return items[id_or_table]
    end
end

-- �Ƿ���һ��װ����Ʒ
-- ˵����������װ������Ϊװ����Ʒ
function Items:IsEquipment(item)
    return Items:_getitem(item).equip
end

-- �Ƿ�������Ʒ
-- ˵����������Ʒ���Ա�ʹ�ã�����Ϊ����Ʒ
function Items:IsConsumable(item)
    return Items:_getitem(item).use
end

-- �Ƿ���һ������Ʒ��
-- ˵����������Ʒ����װ����ͬʱ�޷���Ϊ����Ʒʹ�ã���Ϊ����Ʒ��
function Items:IsItem(item)
    local i = Items:_getitem(item)
    return (not i.equip) and (not i.use)
end

-- ����Ƿ���װ����ʹ��ĳ��Ʒ
-- ����ֵ����һ��Ϊ true �� false���ڶ���Ϊԭ��
function Items:CanUse(ch, item)
    local i = Items:_getitem(item)
    if not i then
        return false, _'�޷��ҵ���Ӧ��Ʒ'
    end

    -- ���������ڵ��ڣ�������С�����ʱ���ش���
    if i.ge then
        for k,v in pairs(i.ge) do
            if v < ch[k] then
                return false, _'�������Բ��ܴﵽҪ��'
            end
        end        
    end
    
    -- ���������ڣ�������С�ڵ������ʱ���ش���
    if i.gt then
        for k,v in pairs(i.gt) do
            if v <= ch[k] then
                return false, _'�������Բ��ܴﵽҪ��'
            end
        end
    end

    -- ���������ڣ�����������ʱ���ش���
    if i.eq then
        for k,v in pairs(i.eq) do
            if v ~= ch[k] then
                return false, _'�������Բ��ܴﵽҪ��'
            end
        end
    end

    -- ��������ȣ�����������ʱ���ش���
    if i.eq then
        for k,v in pairs(i.eq) do
            if v ~= ch[k] then
                return false, _'�������Բ��ܴﵽҪ��'
            end
        end
    end

    -- ������С�ڣ��������ڵ���ʱ���ش���
    if i.lt then
        for k,v in pairs(i.lt) do
            if v >= ch[k] then
                return false, _'�������Գ���Ҫ��'
            end
        end
    end

    -- ������С�ڵ��ڣ���������ʱ���ش���
    if i.le then
        for k,v in pairs(i.le) do
            if v > ch[k] then
                return false, _'�������Գ���Ҫ��'
            end
        end
    end
    
    return true, _'����ʹ��'
end

Items.CanEquip = Items.CanUse
