$(document).ready(function() 
{
	$('table.dataTable tfoot').each(function () 
	{
		$(this).insertAfter($(this).siblings('tbody'));
	});
    // Setup - add a text input to each footer cell
    $('#dataTable tfoot th').each( function () 
    {
    	var title = $(this).text();
       	$(this).html( '<input type="text" placeholder="'+title+'" />' );
	} );
		 
	// DataTable
	var table = $('#dataTable').DataTable({"scrollX": true});
		 
	// Apply the search
	table.columns().every( function () 
	{
		var that = this;
		$( 'input', this.footer() ).on( 'keyup change', function () 
		{
			if ( that.search() !== this.value ) 
			{
		    	that
		        .search( this.value )
		        .draw();
		    }
		 } );
	} );	
} );