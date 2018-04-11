#include "FiveTouch.ch"

function Main()

   local oDlg := QDialog()
   local oLayout := QVBoxLayout()
   local oBrw := QTableView( oDlg )
   local oModel := QStandardItemModel( 3, 4, oDlg )

   oModel:SetHorizontalHeaderItem( 0, QStandardItem( "Header1" ) )
   oModel:SetHorizontalHeaderItem( 1, QStandardItem( "Header2" ) )
   oModel:SetHorizontalHeaderItem( 2, QStandardItem( "Header3" ) )
   oModel:SetHorizontalHeaderItem( 3, QStandardItem( "Header4" ) )

   oModel:SetItem( 0, 0, QStandardItem( "Row1-Col1" ) )
   oModel:SetItem( 1, 0, QStandardItem( "Row2-Col1" ) )
   oModel:SetItem( 2, 0, QStandardItem( "Row3-Col1" ) )

   oModel:SetItem( 0, 1, QStandardItem( "Row1-Col2" ) )
   oModel:SetItem( 1, 1, QStandardItem( "Row2-Col2" ) )
   oModel:SetItem( 2, 1, QStandardItem( "Row3-Col2" ) )

   oDlg:SetLayout( oLayout )
   oBrw:SetModel( oModel )
   oLayout:AddWidget( oBrw )

   oDlg:SetWindowTitle( "A browse" )
   oDlg:Resize( 500, 400 ) 
   oDlg:Center()
   oDlg:Exec()

return nil
