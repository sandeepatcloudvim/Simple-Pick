codeunit 70583000 "Event Trigger"
{
    trigger OnRun()
    begin

    end;
    //Validation error for "Pick Status"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure ValidatePickQuanity(VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; VAR HideProgressWindow: Boolean)
    var
        SimplePickHeader: Record "Simple Pick Header";
        SimplePickSetup: Record "Simple Pick Setup";
    begin
        if SimplePickSetup.Get() then;
        if not SimplePickSetup."Simple Pick" then
            exit;

        SimplePickHeader.RESET;
        SimplePickHeader.SETRANGE("Sales Order No.", SalesHeader."No.");
        SimplePickHeader.SETFILTER("Pick Status", '<>%1', SimplePickHeader."Pick Status"::COMPLETED);
        IF SimplePickHeader.FINDSET THEN begin
            ERROR('All Pick ticket status must be equal to Completed, Version %1 is not yet picked', UpdateVersion(SalesHeader."No."));
        end;

    end;

    local procedure UpdateVersion(OrderNo: Code[20]): Integer
    var
        SimplePickHeader1: Record "Simple Pick Header";
    begin
        SimplePickHeader1.RESET;
        SimplePickHeader1.SETRANGE("Sales Order No.", OrderNo);
        SimplePickHeader1.SETFILTER("Pick Status", '<>%1', SimplePickHeader1."Pick Status"::COMPLETED);
        if SimplePickHeader1.FindFirst() then
            exit(SimplePickHeader1."Version No.");
    end;


}