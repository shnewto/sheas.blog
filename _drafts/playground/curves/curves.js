

function drawPath( QOffsets, AOffsets, path, dotStart, dotEnd ) {

    // get (top, left) coordinates for the two elements
    var x1 = QOffsets.left;
    var y1 = QOffsets.top;

    var x2 = AOffsets.left;
    var y2 = AOffsets.top;

    var scale = (document.body.clientHeight / 6);

    var m1 = (( x1 + x2 ) / 2) - scale;
    var m2 = (( y1 + y2 ) / 2) - scale;
    var m3 = (( x1 + x2 ) / 2) + scale;
    var m4 = (( y1 + y2 ) / 2) + scale;

    path.setAttribute(
        "d",
        "M "  + x1 + " " + y1 + " q " +  m1 + " " + m2 + ", " + m3 + " " + m4 + " T " + x2 + " " + y2  );

    dotStart.setAttribute( "cx", x1 );
    dotStart.setAttribute( "cy", y1 );

    dotEnd.setAttribute( "cx", x2 );
    dotEnd.setAttribute( "cy", y2 );
}

function intertwine() {

    var scale = (document.body.clientHeight / 6);

    var Q1Offsets = document.getElementById( 'q1' ).getBoundingClientRect();
    var A2Offsets = document.getElementById( 'a2' ).getBoundingClientRect();


    // get (top, left) coordinates for the two elements
    var x1 = Q1Offsets.left;
    var y1 = Q1Offsets.top;

    var x2 = A2Offsets.left;
    var y2 = A2Offsets.top;


    var m1 = (( x1 + x2 ) / 2) - scale;
    var m2 = (( y1 + y2 ) / 2) - scale;
    var m3 = (( x1 + x2 ) / 2) + scale;
    var m4 = (( y1 + y2 ) / 2) + scale;

    var path3 = document.getElementById( 'path3' );

    path3.setAttribute(
        "d",
        "M "  + x1 + " " + y1 + " q " +  m1 + " " + m2 + ", " + m3 + " " + m4 + " T " + x2 + " " + y2  );

    var Q2Offsets = document.getElementById( 'q2' ).getBoundingClientRect();
    var A1Offsets = document.getElementById( 'a1' ).getBoundingClientRect();

    // // get (top, left) coordinates for the two elements
    var x3 = Q2Offsets.left;
    var y3 = Q2Offsets.top;
    //
    var x4 = A1Offsets.left;
    var y4 = A1Offsets.top;
    //
    var m5 = (( x3 + x4 ) / 2) - scale;
    var m6 = (( y3 + y4 ) / 2) - scale;
    var m7 = (( x3 + x4 ) / 2) + scale;
    var m8 = (( y3 + y4 ) / 2) + scale;

    var path4 = document.getElementById( 'path4' );

    path4.setAttribute(
        "d",
        "M "  + x3 + " " + y3 + " q " +  m5 + " " + m6 + ", " + m7 + " " + m8 + " T " + x4 + " " + y4  );


}

function loadPaths()
{
    var numQandAsets = 2;

    for( idx = 1; idx <= numQandAsets; idx++ )
    {
        var QOffsets = document.getElementById( 'q' + idx ).getBoundingClientRect();
        var AOffsets = document.getElementById( 'a' + idx ).getBoundingClientRect();
        var path = document.getElementById( 'path' + idx );
        var dotStart = document.getElementById( 'dotStart' + idx );
        var dotEnd = document.getElementById( 'dotEnd' + idx );

        drawPath( QOffsets, AOffsets, path, dotStart, dotEnd );
    }

    // intertwine();
}


function place_divs()
{
    var numQandAsets = 2;

    for( idx = 2; idx <= numQandAsets; idx++ )
    {
        var pos1x = Math.floor(Math.random()*1000);
        var pos1y = Math.floor(Math.random()*100);

        document.getElementById( 'q' + idx ).style.left = pos1x + 'px';
        document.getElementById( 'q' + idx ).style.top = pos1y + 'px';


        var pos2x = Math.floor(Math.random()*1000);
        var pos2y = Math.floor(Math.random()*100);

        document.getElementById( 'a' + idx ).style.left = pos2x + 'px';
        document.getElementById( 'a' + idx ).style.top = pos2y + 'px';
    }

}

var counter = 0;

function show_answer( identifier, is_visible=counter )
{
    ++counter;
    
    if( is_visible % 2 )
    {
        document.getElementById( 'a' + identifier ).style.visibility = 'visible';
        // document.getElementById( 'path' + identifier ).style.visibility = 'visible';
        document.getElementById( 'path' + identifier ).style.display = 'block';
        document.getElementById( 'dotStart' + identifier ).style.visibility = 'visible';
        document.getElementById( 'dotEnd' + identifier ).style.visibility = 'visible';
    }
    else
    {
        document.getElementById( 'a' + identifier ).style.visibility = 'hidden';
        // document.getElementById( 'path' + identifier ).style.visibility = 'hidden';
        document.getElementById( 'path' + identifier ).style.display = 'none';
        document.getElementById( 'dotStart' + identifier ).style.visibility = 'hidden';
        document.getElementById( 'dotEnd' + identifier ).style.visibility = 'hidden';
    }
}


window.onload = function() {

    place_divs();
    loadPaths();

    switch( window.location.hash )
    {
        case '#1' :
        {
            counter = 0;
            show_answer( 1, 1 );
            counter = 1;
            show_answer( 2, 0 );
            console.log( "state 1" );
            break;
        }
        case '#2' :
        {
            counter = 1;
            show_answer( 1, 1 );
            counter = 0;
            show_answer( 2, 0 );
            console.log( "state 2" );
            break;
        }
        case '#3' :
        {
            counter = 0;
            show_answer( 1, 1 );
            counter = 0;
            show_answer( 2, 1 );
            console.log( "state 2" );
            break;
        }
        default :
        {
            counter = 1;
            show_answer( 1, 0 );
            counter = 1;
            show_answer( 2, 0 );
            console.log( "default" );
        }
    }

};


window.onresize = function() {
    loadPaths();
};

