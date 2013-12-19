$(document).ready(function(){
//    an array.
    var menu = $(gon.global.current_menu)[0];
    if (menu == null)
    {

    }
    else
    {
        menu.style.display = "block";
    }
});

function showMenu(id_menu){
    var my_menu = document.getElementById(id_menu);
    closeOtherMenus(my_menu);
    if(my_menu.style.display=="none" || my_menu.style.display==""){
        my_menu.style.display="block";
    } else {
        my_menu.style.display="none";
    }
    gon.global.current_menu = "#" + my_menu.id;
}

function closeOtherMenus(my_menu) {
    var $menuName = $('.sidebarUl');
    for (i = 0; i < $menuName.length; i ++)
    {
        if ($menuName[i] != my_menu)
        {
            $menuName[i].style.display = "none";
        }
    }
}

//EASY TABS 1.2 - MENU SETTINGS
//Set the id names of your tablink (without a number at the end)
var tablink_idname = new Array("tablink");
//Set the id name of your tabcontentarea (without a number at the end)
var tabcontent_idname = new Array("tabcontent");
//Set the number of your tabs
var tabcount = new Array("3");
//Set the Tab which should load at start (In this Example:Tab 2 visible on load)
var loadtabs = new Array("1");
//Set the Number of the Menu which should autochange (if you dont't want to have a change menu set it to 0)
var autochangemenu = 0;
//the speed in seconds when the tabs should change
var changespeed = 3;
//should the autochange stop if the user hover over a tab from the autochangemenu? 0=no 1=yes
var stoponhover = 0;
//END MENU SETTINGS

/*Swich EasyTabs Functions - no need to edit something here*/
function easytabs(menunr, active) {
    if (menunr == autochangemenu){currenttab=active;}
    if ((menunr == autochangemenu)&&(stoponhover==1)){
        stop_autochange()
    }
    else if ((menunr == autochangemenu)&&(stoponhover==0)){
        counter=0;
    }
    menunr = menunr-1;
    for (i=1; i <= tabcount[menunr]; i++){
        document.getElementById(tablink_idname[menunr]+i).className='tab'+i;
        document.getElementById(tabcontent_idname[menunr]+i).style.display = 'none';}
    document.getElementById(tablink_idname[menunr]+active).className='tab'+active+' tabactive';
    document.getElementById(tabcontent_idname[menunr]+active).style.display = 'block';}
var timer; counter=0;
var totaltabs=tabcount[autochangemenu-1];
var currenttab=loadtabs[autochangemenu-1];
function start_autochange(){
    counter=counter+1;
    timer=setTimeout("start_autochange()",1000);
    if (counter == changespeed+1) {
        currenttab++;
        if (currenttab>totaltabs) {
            currenttab=1}
        easytabs(autochangemenu,currenttab);
        restart_autochange();}}
function restart_autochange(){clearTimeout(timer);counter=0;start_autochange();}
function stop_autochange(){clearTimeout(timer);counter=0;}

window.onload=function(){
    var menucount=loadtabs.length;
    var a = 0; var b = 1;
    do {easytabs(b, loadtabs[a]);  a++; b++;}
    while (b<=menucount);
    if (autochangemenu!=0){start_autochange();}
};



//侧栏跟随

//(function(){
//    var oDiv=document.getElementById("sidebar-wrap");
//    var H=0,iE6;
//    var Y=oDiv;
//    while(Y){H+=Y.offsetTop;Y=Y.offsetParent};
//    iE6=window.ActiveXObject&&!window.XMLHttpRequest;
//    if(!iE6){
//        window.onscroll=function()
//        {
//            var s=document.body.scrollTop||document.documentElement.scrollTop;
//            if(s>H){oDiv.className="div1 div2";if(iE6){oDiv.style.top=(s-H)+"px";}}
//            else{oDiv.className="div1";}
//        };
//    }
//
//})();

//var documentHeight = 0;
//var topPadding = 15;
//$(function() {
//    var offset = $("#sidebar-wrap").offset();
//    documentHeight = $(document).height();
//    $(window).scroll(function() {
//        var sideBarHeight = $("#sidebar-wrap").height();
//        if ($(window).scrollTop() > offset.top) {
//            var newPosition = ($(window).scrollTop() – offset.top) + topPadding;
//            var maxPosition = documentHeight – (sideBarHeight + 368);
//            if (newPosition > maxPosition) {
//                newPosition = maxPosition;
//            }
//            $("#sidebar-wrap").stop().animate({
//                marginTop: newPosition
//            });
//        } else {
//            $("#sidebar-wrap").stop().animate({
//                marginTop: 0
//            });
//        };
//    });
//});


$('#sidebar-wrap').fixbox({});
$("#sidebar-wrap").fixbox({distanceToBottom:10,isFixdeHeight:false,isFixdeDocHeight:false,threshold:2});
$(document).ready(function(){
    console.log($(document).height());
});
