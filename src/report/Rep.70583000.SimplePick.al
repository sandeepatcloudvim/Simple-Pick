report 70583000 "Simple Pick Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SimplePickReport.rdl';

    dataset
    {
        dataitem("Simple Pick Header"; "Simple Pick Header")
        {
            PrintOnlyIfDetail = true;
            column(DateTxt; DateTxt)
            {
            }
            column(DocLabel; DocLabel)
            {
            }
            column(VersionLabel; VersionLabel)
            {
            }
            column(ItemLable; ItemLable)
            {
            }
            column(DesLabel; DesLabel)
            {
            }
            column(QtyLabel; QtyLabel)
            {
            }
            column(QtyPicked; QtyPicked)
            {

            }
            column(ShelfNoLbl; ShelfNoLbl)
            {

            }
            column(SalesOrderLabel; SalesOrderLabel)
            {
            }
            column(SimpleCaptionLabel; SimpleCaptionLabel)
            {
            }
            column(CompanyAddress1; CompanyAddress[1])
            {
            }
            column(CompanyAddress2; CompanyAddress[2])
            {
            }
            column(CompanyAddress3; CompanyAddress[3])
            {
            }
            column(CompanyAddress4; CompanyAddress[4])
            {
            }
            column(CompanyAddress5; CompanyAddress[5])
            {
            }
            column(CompanyAddress6; CompanyAddress[6])
            {
            }
            column(DocumentNo_SimplePickHeader; "Simple Pick Header"."Document No.")
            {
            }
            column(PickCreationDate_SimplePickHeader; "Simple Pick Header"."Pick Creation Date")
            {
            }
            column(SalesOrderNo_SimplePickHeader; "Simple Pick Header"."Sales Order No.")
            {
            }
            column(VersionNo_SimplePickHeader; "Simple Pick Header"."Version No.")
            {
            }
            dataitem("Simple Pick Line"; "Simple Pick Line")
            {
                DataItemLink = "Document No." = FIELD("Document No."), "Version No." = FIELD("Version No.");
                DataItemTableView = SORTING("Document No.", "Version No.", "Line No.") ORDER(Ascending);
                column(DocumentNo_SimplePickLine; "Simple Pick Line"."Document No.")
                {
                }
                column(VersionNo_SimplePickLine; "Simple Pick Line"."Version No.")
                {
                }
                column(LineNo_SimplePickLine; "Simple Pick Line"."Line No.")
                {
                }
                column(SalesOrderNo_SimplePickLine; "Simple Pick Line"."Sales Order No")
                {
                }
                column(QtytoPick_SimplePickLine; "Simple Pick Line"."Qty. to Pick")
                {
                }
                column(Qty_Picked_SimplePickLine; "Simple Pick Line"."Qty. Picked")
                {

                }
                column(ItemNo_SimplePickLine; "Simple Pick Line"."Item No.")
                {
                }
                column(Description_SimplePickLine; "Simple Pick Line".Description)
                {
                }
                column(LineQuantity_SimplePickLine; "Simple Pick Line"."Line Quantity")
                {
                }
                column(ShelfNo_Item; recItem."Shelf No.")
                {

                }
                trigger OnAfterGetRecord()
                var
                begin
                    if recItem.Get("Simple Pick Line"."Item No.") then;
                end;

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get;
        DateTxt := Format(Today);
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        FormatAddress.Company(CompanyAddress, CompanyInfo)
    end;

    trigger OnPostReport()
    begin
        "Simple Pick Header"."Pick Status" := "Simple Pick Header"."Pick Status"::PRINTED;
        "Simple Pick Header".Modify(false);
    end;

    var
        CompanyInfo: Record "Company Information";
        FormatAddress: Codeunit "Format Address";
        CompanyAddress: array[8] of Text[100];
        DateTxt: Text;
        DocLabel: Label 'Document No.';
        VersionLabel: Label 'Version No.';
        ItemLable: Label 'Item No.';
        DesLabel: Label 'Description';
        QtyLabel: Label 'Qty to Pick';
        QtyPicked: Label 'Qty Picked';
        ShelfNoLbl: Label 'Shelf No.';
        SimpleCaptionLabel: Label 'Simple Pick Report';
        SalesOrderLabel: Label 'Sales Order No.';
        recItem: Record Item;
}

