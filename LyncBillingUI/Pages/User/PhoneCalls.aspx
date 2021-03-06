﻿<%@ Page Title="My Phone Calls" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PhoneCalls.aspx.cs" Inherits="LyncBillingUI.Pages.User.PhoneCalls" %>

<asp:Content ID="HeaderScripts" ContentPlaceHolderID="HeaderContent" runat="server">    
</asp:Content>


<asp:Content ID="BodyContents" ContentPlaceHolderID="MainContent" runat="server">
    <ext:Hidden ID="FormatType" runat="server" />

    <div class="row">
        <div class="col-md-12">

            <ext:TabPanel
                ID="PhoneCallsTabsPanel"
                runat="server"
                Title="Phone Calls Allocation"
                MaxWidth="955"
                MinHeight="600"
                Plain="false">

                <DirectEvents>
                    <TabChange OnEvent="PhoneCallsTabsPanel_TabChange"></TabChange>
                </DirectEvents>


                <Items>
                    <%-- 
                        ==========================================
                        MY PHONE CALLS TAB BODY
                        ==========================================
                    --%>
                    <ext:GridPanel
                        ID="MyPhoneCallsGrid"
                        runat="server"
                        Border="true"
                        AutoScroll="true"
                        Scroll="Both"
                        Layout="FitLayout"
                        MaxWidth="955"
                        MinHeight="580"
                        Header="true"
                        Title="My Phone Calls"
                        ContextMenuID="PhoneCallsAllocationToolsMenu">

                        <Store>
                            <ext:Store
                                ID="MyPhoneCallsStore"
                                runat="server"
                                PageSize="25"
                                IsPagingStore="true"
                                OnLoad="MyPhoneCallsStore_Load">

                                <Model>
                                    <ext:Model ID="PhoneCallsStoreModel" runat="server" IDProperty="SessionIdTime">
                                        <Fields>
                                            <ext:ModelField Name="ChargingParty" Type="String" />
                                            <ext:ModelField Name="SessionIdTime" Type="Date" />
                                            <ext:ModelField Name="SessionIdSeq" Type="Int" />
                                            <ext:ModelField Name="ResponseTime" Type="Date" />
                                            <ext:ModelField Name="SessionEndTime" Type="Date" />
                                            <ext:ModelField Name="MarkerCallToCountry" Type="String" />
                                            <ext:ModelField Name="MarkerCallType" Type="String" />
                                            <ext:ModelField Name="DestinationNumberUri" Type="String" />
                                            <ext:ModelField Name="Duration" Type="Float" />
                                            <ext:ModelField Name="MarkerCallCost" Type="Float" />
                                            <ext:ModelField Name="UiAssignedByUser" Type="String" />
                                            <ext:ModelField Name="UiAssignedToUser" Type="String" />
                                            <ext:ModelField Name="UiAssignedOn" Type="Date" />
                                            <ext:ModelField Name="UiCallType" Type="String" />
                                            <ext:ModelField Name="UiMarkedOn" Type="Date" />
                                            <ext:ModelField Name="PhoneBookName" Type="String" />
                                            <ext:ModelField Name="PhoneCallsTableName" Type="String" />
                                        </Fields>
                                    </ext:Model>
                                </Model>

                                <Sorters>
                                    <ext:DataSorter Property="SessionIdTime" Direction="DESC" />
                                </Sorters>
                            </ext:Store>
                        </Store>

                        <Plugins>
                            <ext:FilterHeader runat="server" CaseSensitive="false" DateFormat="yyyy-mm-dd" />
                            <ext:CellEditing ID="CellEditingPlugin" runat="server" ClicksToEdit="2" />
                        </Plugins>

                        <ColumnModel ID="ColumnModel1" runat="server" Flex="1">
                            <Columns>
                                <ext:RowNumbererColumn
                                    ID="RowNumbererColumn2"
                                    runat="server"
                                    MinWidth="40" />

                                <ext:DateColumn
                                    ID="SessionIdTime"
                                    runat="server"
                                    Text="Date"
                                    MinWidth="150"
                                    MaxWidth="160"
                                    DataIndex="SessionIdTime"
                                    Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>

                                <ext:Column
                                    ID="MarkerCallToCountry"
                                    runat="server"
                                    Text="Country"
                                    Width="80"
                                    DataIndex="MarkerCallToCountry">
                                </ext:Column>

                                <ext:Column
                                    ID="DestinationNumberUri"
                                    runat="server"
                                    Text="Destination"
                                    MinWidth="140"
                                    MaxWidth="160"
                                    DataIndex="DestinationNumberUri">
                                </ext:Column>

                                <ext:Column ID="PhoneBookNameCol"
                                    runat="server"
                                    Text="Contact Name"
                                    MinWidth="220"
                                    MaxWidth="240"
                                    DataIndex="PhoneBookName">
                                    <Editor>
                                        <ext:TextField
                                            ID="PhoneBookNameEditorTextbox"
                                            runat="server"
                                            DataIndex="PhoneBookName"
                                            EmptyText="Add a contact name"
                                            ReadOnly="false" />
                                    </Editor>
                                </ext:Column>

                                <ext:Column
                                    ID="Duration"
                                    runat="server"
                                    Text="Duration"
                                    MinWidth="60"
                                    DataIndex="Duration">
                                    <Renderer Fn="GetMinutes" />
                                </ext:Column>

                                <ext:Column
                                    ID="MarkerCallCost"
                                    runat="server"
                                    Text="Cost"
                                    MinWidth="60"
                                    DataIndex="MarkerCallCost">
                                    <Renderer Fn="RoundCost" />
                                </ext:Column>

                                <ext:Column
                                    ID="MarkerCallTypeCol"
                                    runat="server"
                                    Text="Call Type"
                                    MinWidth="60"
                                    DataIndex="MarkerCallType">
                                    <Renderer Fn="markerCallTypeHandler" />
                                </ext:Column>
                            </Columns>
                        </ColumnModel>

                        <SelectionModel>
                            <ext:RowSelectionModel ID="CheckboxSelectionModel1"
                                runat="server"
                                Mode="Multi"
                                AllowDeselect="true"
                                IgnoreRightMouseSelection="true"
                                CheckOnly="true">
                            </ext:RowSelectionModel>
                        </SelectionModel>

                        <TopBar>
                            <ext:Toolbar
                                ID="FilterToolbar1"
                                runat="server">
                                <Items>
                                    <ext:ComboBox
                                        ID="FilterTypeComboBox"
                                        runat="server"
                                        Icon="Find"
                                        TriggerAction="All"
                                        QueryMode="Local"
                                        DisplayField="TypeName"
                                        ValueField="TypeValue"
                                        FieldLabel="View Calls:"
                                        LabelWidth="70"
                                        Width="220"
                                        MarginSpec="5 5 5 5">
                                        <Items>
                                            <ext:ListItem Text="Unallocated" Value="Unallocated" />
                                            <ext:ListItem Text="Business" Value="Business" />
                                            <ext:ListItem Text="Personal" Value="Personal" />
                                            <ext:ListItem Text="Disputed" Value="Disputed" />
                                        </Items>
                                        
                                        <SelectedItems>
                                            <ext:ListItem Text="Unallocated" Value="Unallocated" />
                                        </SelectedItems>

                                        <DirectEvents>
                                            <Select OnEvent="PhoneCallsTypeFilter" Timeout="500000" />
                                        </DirectEvents>

                                        <%--<Listeners>
                                            <BeforeSelect Fn="clearFilter" />
                                        </Listeners>--%>
                                    </ext:ComboBox>

                                    <ext:Button
                                        ID="HelpDialogButton"
                                        runat="server"
                                        Text="Help"
                                        Icon="Help"
                                        Margins="5 5 5 465">
                                        <DirectEvents>
                                            <Click OnEvent="ShowUserHelpPanel" />
                                        </DirectEvents>
                                    </ext:Button>

                                    <ext:Window 
                                        ID="UserHelpPanel" 
                                        runat="server" 
                                        Layout="Accordion" 
                                        Icon="Help" 
                                        Title="User Help" 
                                        Hidden="true" 
                                        Width="320" 
                                        Height="420" 
                                        Frame="true" 
                                        X="150" 
                                        Y="100"
                                        ComponentCls="fix-ui-vertical-align">
                                        <Items>
                                            <ext:Panel ID="MultipleSelectPanel" runat="server" Icon="Anchor" Title="How do I select multiple Phonecalls?">
                                                <Content>
                                                    <div class="text-left p10">
                                                        <p class='font-14 line-height-1-5'>You can select multiple phonecalls by pressing either of the <span class="bold red-color">&nbsp;[Ctrl]&nbsp;</span> or the <span class="bold red-color">&nbsp;[Shift]&nbsp;</span> buttons.</p>
                                                    </div>
                                                </Content>
                                            </ext:Panel>

                                            <ext:Panel ID="AllocatePhonecalls" runat="server" Icon="ApplicationEdit" Title="How do I allocate my Phonecalls?">
                                                <Content>
                                                    <div class="p10 text-left font-14 line-height-1-5 over-h">
                                                        <p class="mb10">You can allocate your phonecalls by <span class="bold red-color">&nbsp;[Right Clicking]&nbsp;</span> on the selected phonecalls and choosing your preferred action from the first section of the menu - <span class="blue-color">Selected Phonecalls</span> section.</p>
                                                        <p>The list of actions is:</p>
                                                        <ol class="ml35" style="list-style-type: decimal">
                                                            <li>As Business</li>
                                                            <li>As Personal</li>
                                                            <li>As Disputed</li>
                                                        </ol>
                                                    </div>
                                                </Content>
                                            </ext:Panel>

                                            <ext:Panel ID="MarkPhoneCallsAndDestinations" runat="server" Icon="ApplicationSideList" Title="How do I allocate Destinations?">
                                                <Content>
                                                    <div class="p10 text-left font-14 line-height-1-5">
                                                        <p class="mb10">If you <span class="bold red-color">&nbsp;[Right Click]&nbsp;</span> on the grid, you can mark the destination(s) of your selected phonecall(s) as either <span class="bold">Always Business</span> or <span class="bold">Always Personal</span> from the second section of menu - <span class="blue-color">Selected Destinations</span> section.</p>
                                                        <p>Please note that marking a destination results in adding it to your phonebook, and from that moment on any phonecall to that destination will be marked automatically as the type of this phonebook contact (Business/Personal).</p>
                                                    </div>
                                                </Content>
                                            </ext:Panel>

                                            <ext:Panel ID="AssignContactNamesToDestinations" runat="server" Icon="User" Title="How do I assign &quot;Contact Names&quot; to Destinations?">
                                                <Content>
                                                    <div class="text-left p10">
                                                        <p class="font-14 line-height-1-5">You can add Contact Name to a phonecall destination by <span class="bold red-color">&nbsp;[Double Clicking]&nbsp;</span> on the <span class="blue-color">&nbsp;&quot;Contact Name&quot;&nbsp;</span> field and then filling the text box, please note that this works for the Unallocated phonecalls.</p>
                                                    </div>
                                                </Content>
                                            </ext:Panel>
                                        </Items>
                                    </ext:Window>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>

                        <BottomBar>
                            <ext:PagingToolbar
                                ID="PagingToolbar1"
                                runat="server"
                                StoreID="PhoneCallStore"
                                DisplayInfo="true"
                                Weight="25"
                                DisplayMsg="Phone Calls {0} - {1} of {2}" />
                        </BottomBar>
                    </ext:GridPanel>


                    <%-- 
                        ================================================
                        MY DEPARTMENT"S PHONE CALLS TAB BODY
                        ================================================
                    --%>
                    <ext:GridPanel
                        ID="DepartmentPhoneCallsGrid"
                        runat="server"
                        Border="true"
                        AutoScroll="true"
                        Scroll="Both"
                        Layout="FitLayout"
                        MaxWidth="955"
                        MinHeight="600"
                        Header="true"
                        Title="My Department's Calls"
                        ContextMenuID="DepartmentPhonecallsAllocationMenu">
                        <Store>
                            <ext:Store 
                                ID="DepartmentPhoneCallsStore"
                                runat="server"
                                PageSize="25"
                                OnLoad="DepartmentPhoneCallsStore_Load">

                                <Model>
                                    <ext:Model ID="Model1" runat="server" IDProperty="SessionIdTime">
                                        <Fields>
                                            <ext:ModelField Name="ChargingParty" Type="String" />
                                            <ext:ModelField Name="SessionIdTime" Type="Date" />
                                            <ext:ModelField Name="SessionIdSeq" Type="Int" />
                                            <ext:ModelField Name="ResponseTime" Type="Date" />
                                            <ext:ModelField Name="SessionEndTime" Type="Date" />
                                            <ext:ModelField Name="MarkerCallToCountry" Type="String" />
                                            <ext:ModelField Name="MarkerCallType" Type="String" />
                                            <ext:ModelField Name="DestinationNumberUri" Type="String" />
                                            <ext:ModelField Name="Duration" Type="Float" />
                                            <ext:ModelField Name="MarkerCallCost" Type="Float" />
                                            <ext:ModelField Name="UiAssignedByUser" Type="String" />
                                            <ext:ModelField Name="UiAssignedToUser" Type="String" />
                                            <ext:ModelField Name="UiAssignedOn" Type="Date" />
                                            <ext:ModelField Name="UiCallType" Type="String" />
                                            <ext:ModelField Name="UiMarkedOn" Type="Date" />
                                            <ext:ModelField Name="PhoneBookName" Type="String" />
                                            <ext:ModelField Name="PhoneCallsTableName" Type="String" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                                <Sorters>
                                    <ext:DataSorter Property="SessionIdTime" Direction="DESC" />
                                </Sorters>
                            </ext:Store>
                        </Store>

                        <Plugins>
                            <ext:FilterHeader runat="server" />
                        </Plugins>

                        <ColumnModel ID="ColumnModel2" runat="server" Flex="1">
                            <Columns>
                                <ext:RowNumbererColumn
                                    runat="server"
                                    Width="25" />

                                <ext:DateColumn
                                    ID="DepartmentPhoneCallsSessionIdTime"
                                    runat="server"
                                    Text="Date"
                                    Width="140"
                                    DataIndex="SessionIdTime"
                                    Format="yyyy-MM-dd HH:mm:ss">
                                </ext:DateColumn>

                                <ext:Column
                                    ID="DepartmentPhoneCallsMarkerCallToCountry"
                                    runat="server"
                                    Text="Country"
                                    Width="70"
                                    DataIndex="MarkerCallToCountry" />

                                <ext:Column
                                    ID="DepartmentPhoneCallsDestinationNumberUri"
                                    runat="server"
                                    Text="Destination"
                                    Width="120"
                                    DataIndex="DestinationNumberUri" />

                                <ext:Column
                                    ID="DepartmentPhoneCallsUiAssignedByUser"
                                    runat="server"
                                    Text="Assigned By"
                                    Width="140"
                                    DataIndex="UiAssignedByUser">
                                </ext:Column>

                                <ext:Column
                                    ID="DepartmentPhoneCallsDuration"
                                    runat="server"
                                    Text="Duration"
                                    Width="80"
                                    DataIndex="Duration">
                                    <Renderer Fn="GetMinutes" />
                                </ext:Column>
                                
                                <ext:Column
                                    ID="DepartmentPhoneCallsUiAssignedOn"
                                    runat="server"
                                    Text="Assigned On"
                                    Width="160"
                                    DataIndex="UiAssignedOn">
                                    <%--<Renderer Fn="DateRenderer" />--%>
                                </ext:Column>
                            </Columns>
                        </ColumnModel>
                
                        <SelectionModel>
                            <ext:RowSelectionModel ID="RowSelectionModel1"
                                runat="server"
                                Mode="Multi"
                                AllowDeselect="true"
                                IgnoreRightMouseSelection="true"
                                CheckOnly="true">
                            </ext:RowSelectionModel>
                        </SelectionModel>

                        <TopBar>
                            <ext:Toolbar
                                ID="Toolbar1"
                                runat="server">
                                <Items>
                                    <ext:Button
                                        ID="DepartmentPhoneCalls_HelpButton"
                                        runat="server"
                                        Text="Help"
                                        Icon="Help"
                                        MarginSpec="5 5 5 5">
                                        <DirectEvents>
                                            <Click OnEvent="ShowUserHelpPanel" />
                                        </DirectEvents>
                                    </ext:Button>

                                    <ext:Window 
                                        ID="Window1" 
                                        runat="server" 
                                        Layout="Accordion" 
                                        Icon="Help" 
                                        Title="User Help" 
                                        Hidden="true" 
                                        Width="320" 
                                        Height="420" 
                                        Frame="true" 
                                        X="150" 
                                        Y="100">
                                        <Items>
                                            <ext:Panel ID="Panel1" runat="server" Icon="Anchor" Title="How do I select multiple Phonecalls?">
                                                <Content>
                                                    <div class="text-left p10">
                                                        <p class='font-14 line-height-1-5'>You can select multiple phonecalls by pressing either of the <span class="bold red-color">&nbsp;[Ctrl]&nbsp;</span> or the <span class="bold red-color">&nbsp;[Shift]&nbsp;</span> buttons.</p>
                                                    </div>
                                                </Content>
                                            </ext:Panel>

                                            <ext:Panel ID="Panel2" runat="server" Icon="ApplicationEdit" Title="How do I allocate my Phonecalls?">
                                                <Content>
                                                    <div class="p10 text-left font-14 line-height-1-5 over-h">
                                                        <p class="mb10">You can allocate your phonecalls by <span class="bold red-color">&nbsp;[Right Clicking]&nbsp;</span> on the selected phonecalls and choosing your preferred action from the first section of the menu - <span class="blue-color">Selected Phonecalls</span> section.</p>
                                                        <p>The list of actions is:</p>
                                                        <ol class="ml35" style="list-style-type: decimal">
                                                            <li>As Business</li>
                                                            <li>As Personal</li>
                                                            <li>As Disputed</li>
                                                        </ol>
                                                    </div>
                                                </Content>
                                            </ext:Panel>

                                            <ext:Panel ID="Panel3" runat="server" Icon="ApplicationSideList" Title="How do I allocate Destinations?">
                                                <Content>
                                                    <div class="p10 text-left font-14 line-height-1-5">
                                                        <p class="mb10">If you <span class="bold red-color">&nbsp;[Right Click]&nbsp;</span> on the grid, you can mark the destination(s) of your selected phonecall(s) as either <span class="bold">Always Business</span> or <span class="bold">Always Personal</span> from the second section of menu - <span class="blue-color">Selected Destinations</span> section.</p>
                                                        <p>Please note that marking a destination results in adding it to your phonebook, and from that moment on any phonecall to that destination will be marked automatically as the type of this phonebook contact (Business/Personal).</p>
                                                    </div>
                                                </Content>
                                            </ext:Panel>

                                            <ext:Panel ID="Panel4" runat="server" Icon="User" Title="How do I assign &quot;Contact Names&quot; to Destinations?">
                                                <Content>
                                                    <div class="text-left p10">
                                                        <p class="font-14 line-height-1-5">You can add Contact Name to a phonecall destination by <span class="bold red-color">&nbsp;[Double Clicking]&nbsp;</span> on the <span class="blue-color">&nbsp;&quot;Contact Name&quot;&nbsp;</span> field and then filling the text box, please note that this works for the Unallocated phonecalls.</p>
                                                    </div>
                                                </Content>
                                            </ext:Panel>
                                        </Items>
                                    </ext:Window>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>

                        <BottomBar>
                            <ext:PagingToolbar
                                ID="PagingToolbar2"
                                runat="server"
                                StoreID="PhoneCallStore"
                                DisplayInfo="true"
                                Weight="25"
                                DisplayMsg="Phone Calls {0} - {1} of {2}" />
                        </BottomBar>
                    </ext:GridPanel>
                </Items>
            </ext:TabPanel>
        </div>
    </div>
    

    
    <%-- 
        [Right Click] GRIDS MENUS 
    --%>


    <ext:Menu
        ID="PhoneCallsAllocationToolsMenu"
        runat="server"
        Width="190"
        Frame="false"
        ComponentCls="fix-ui-vertical-align">
        <Items>
            <ext:MenuItem
                runat="server"
                ID="AllocPhonecallsFieldLabel"
                Text="Selected Phonecall(s):"
                Margins="5 0 5 0"
                Disabled="true"
                Enabled="false"
                Cls="extjs-menuitem-label" />

            <ext:MenuItem
                ID="AllocatePhonecallsAsBusiness"
                Text="As Business"
                runat="server">
                <DirectEvents>
                    <Click OnEvent="AssignBusiness" Timeout="500000">
                        <EventMask ShowMask="true" />
                        <ExtraParams>
                            <ext:Parameter Name="Values" Value="Ext.encode(#{ManagePhoneCallsGrid}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                        </ExtraParams>
                    </Click>
                </DirectEvents>
            </ext:MenuItem>

            <ext:MenuItem
                ID="AllocatePhonecallsAsPersonal"
                Text="As Personal"
                runat="server">
                <DirectEvents>
                    <Click OnEvent="AssignPersonal" Timeout="500000">
                        <EventMask ShowMask="true" />
                        <ExtraParams>
                            <ext:Parameter Name="Values" Value="Ext.encode(#{ManagePhoneCallsGrid}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                        </ExtraParams>
                    </Click>
                </DirectEvents>
            </ext:MenuItem>

            <ext:MenuItem
                ID="AllocatePhonecallsAsDispute"
                Text="As Disputed"
                runat="server">
                <DirectEvents>
                    <Click OnEvent="AssignDispute" Timeout="500000">
                        <EventMask ShowMask="true" />
                        <ExtraParams>
                            <ext:Parameter Name="Values" Value="Ext.encode(#{ManagePhoneCallsGrid}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                        </ExtraParams>
                    </Click>
                </DirectEvents>
            </ext:MenuItem>

            <ext:MenuSeparator ID="MenuSeparator" runat="server" />

            <ext:MenuItem
                runat="server"
                ID="AllocDestinationsFieldLabel"
                Text="Selected Destination(s):"
                Margins="5 0 5 0"
                Disabled="true"
                Enabled="false"
                Cls="extjs-menuitem-label" />

            <ext:MenuItem
                ID="AllocateDestinationsAsAlwaysBusiness"
                Text="Always As Business"
                runat="server"
                Margins="0 0 5 0">
                <DirectEvents>
                    <Click OnEvent="AssignAlwaysBusiness" Timeout="500000">
                        <EventMask ShowMask="true" />
                        <ExtraParams>
                            <ext:Parameter Name="Values" Value="Ext.encode(#{ManagePhoneCallsGrid}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                        </ExtraParams>
                    </Click>
                </DirectEvents>
            </ext:MenuItem>

            <ext:MenuItem
                ID="AllocateDestinationsAsAlwaysPersonal"
                Text="Always As Personal"
                runat="server"
                Margins="0 0 5 0">
                <DirectEvents>
                    <Click OnEvent="AssignAlwaysPersonal" Timeout="500000">
                        <EventMask ShowMask="true" />
                        <ExtraParams>
                            <ext:Parameter Name="Values" Value="Ext.encode(#{ManagePhoneCallsGrid}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                        </ExtraParams>
                    </Click>
                </DirectEvents>
            </ext:MenuItem>

            <ext:MenuSeparator ID="MenuSeparator1" runat="server" />

            <ext:MenuItem
                runat="server"
                ID="MoveToDepartmentFieldLabel"
                Text="Move Selected To:"
                Margins="5 0 5 0"
                Disabled="true"
                Enabled="false"
                Cls="extjs-menuitem-label" />

            <ext:MenuItem
                ID="MoveToDepartmnet"
                Text="My Department's Phonecalls"
                runat="server"
                Margins="0 0 5 0">
                <DirectEvents>
                    <Click OnEvent="MoveToDepartmnent" Timeout="500000">
                        <EventMask ShowMask="true" />
                        <ExtraParams>
                            <ext:Parameter Name="Values" Value="Ext.encode(#{ManagePhoneCallsGrid}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                        </ExtraParams>
                    </Click>
                </DirectEvents>
            </ext:MenuItem>
        </Items>

        <DirectEvents>
            <BeforeShow OnEvent="PhoneCallsGridSelectDirectEvents">
                <ExtraParams>
                        <ext:Parameter Name="Values" Value="Ext.encode(#{ManagePhoneCallsGrid}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                </ExtraParams>
            </BeforeShow>
        </DirectEvents>
    </ext:Menu>

    <ext:Menu
        ID="DepartmentPhonecallsAllocationMenu"
        runat="server"
        Width="170"
        Frame="false">
        <Items>
            <ext:MenuItem
                runat="server"
                ID="AssignSelectedPhonecallsToMeFieldLabel"
                Text="Move Selected To:"
                Margins="5 0 5 0"
                Disabled="true"
                Enabled="false"
                Cls="extjs-menuitem-label" />

            <ext:MenuItem
                ID="AssignSelectedPhonecallsToMeButton"
                Text="My Phonecalls"
                runat="server"
                Margins="0 0 5 0">
                <DirectEvents>
                    <Click OnEvent="AssignSelectedPhonecallsToMe_DirectEvent" Timeout="500000">
                        <EventMask ShowMask="true" />
                        <ExtraParams>
                            <ext:Parameter Name="Values" Value="Ext.encode(#{DepartmentPhoneCallsGrid}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                        </ExtraParams>
                    </Click>
                </DirectEvents>
            </ext:MenuItem>
        </Items>
    </ext:Menu>
</asp:Content>


<asp:Content runat="server" ID="Scripts" ContentPlaceHolderID="EndOfBodyScripts">
    <script type="text/javascript">
        function markerCallTypeHandler(value)
        {
            var type = "N/A";
            
            if(value == undefined || value == null)
                return type;

            value = value.toLowerCase();

            if(value.includes("fixedline"))
                type = "Fixedline";
            else if(value.includes("mobile"))
                type = "Mobile";
            
            return type;
        }
    </script>
</asp:Content>