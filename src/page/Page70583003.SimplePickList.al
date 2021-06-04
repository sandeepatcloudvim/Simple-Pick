page 70583003 "Simple Pick List"
{
    Caption = 'Simple Pick List';
    CardPageID = "Simple Pick";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Simple Pick Header";
    ApplicationArea = Basic, Suite, Assembly;
    UsageCategory = ReportsAndAnalysis;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;

                }
                field("Pick Creation Date"; Rec."Pick Creation Date")
                {
                    ApplicationArea = All;

                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;

                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;

                }
                field("Pick Status"; Rec."Pick Status")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}