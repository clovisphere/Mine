program Mine;

type
    Cell = (Empty, Bomb); // like an ENUM 🤭
    Field = record
        Cells: array of Cell;
        Rows: Integer;
        Cols: Integer;
    end;


function FieldGet(Field: Field; Row, Col: Integer): Cell;
begin
    FieldGet := Field.Cells[Row*Field.Cols + Col];
end;

procedure FieldSet(var Field: Field; Row, Col: Integer; Cell: Cell);
begin
    Field.Cells[Row*Field.Cols + Col] := Cell
end;

procedure FieldResize(var Field: Field; Rows, Cols: Integer);
    var
        Index: Integer;
begin
    SetLength(Field.Cells, Rows*Cols);
    for Index := 0 to Rows*Cols do Field.Cells[Index] := Empty;
    Field.Rows := Rows;
    Field.Cols := Cols;
end;

function FieldCheckedGet(Field: Field; Row, Col: Integer; var Cell: Cell): Boolean;
begin
    FieldCheckedGet := (0 <= Row) and (Row < Field.Rows) and (0 <= Col) and (Col < Field.Cols);
    if FieldCheckedGet then Cell := FieldGet(Field, Row, Col);
end;

function FieldCountNeighbors(Field: Field; Row, Col: Integer): Integer;
var
    DRow, DCol: Integer;
    C: Cell;
begin
    FieldCountNeighbors := 0;
    for DRow := -1 to 1 do
        for DCol := -1 to 1 do
            if (DRow <> 0) or (DCol <> 0) then
                if FieldCheckedGet(Field, Row + DRow, Col + DCol, C) then
                    if C = Bomb then
                        inc(FieldCountNeighbors);
end;

procedure FieldWrite(Field: Field);
var
    Row, Col, Neighbors: Integer;
begin
    for Row := 0 to Field.Rows-1 do
    begin
        for Col := 0 to Field.Cols-1 do
            case FieldGet(Field, Row, Col) of
                Bomb: Write('*');
                Empty: begin
                          Neighbors := FieldCountNeighbors(Field, Row, Col);
                          if Neighbors > 0 then Write(Neighbors) else Write(' ');
                       end;
            end;
        WriteLn
    end
end;

var
    MainField: Field;

// application entrypoint 🤫
begin
    WriteLn(' Mine 😆 ');
    WriteLn;
    FieldResize(MainField, 10, 10);
    FieldWrite(MainField);
end.
