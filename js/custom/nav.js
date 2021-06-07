var path = location.pathname.split('/');
var path = path[path.length - 1];
var nav_links = document.getElementsByClassName('nav-link');
for(let i = 0; i < nav_links.length; i++){
    
    path_nav = nav_links[i].href.split('/');
    path_nav = path_nav[path_nav.length - 1];
    if(path == path_nav){
        if(nav_links[i].parentElement.classList.contains('dropdown-menu')){
            nav_links[i].classList.add('nav-select-dropdown');
            nav_links[i].parentElement.previousElementSibling.classList.add('nav-select');
        }
        else{
            nav_links[i].classList.add('nav-select')
        }
    }
}

const navbar = document.getElementById('ftco-navbar');
const observer = new MutationObserver(() => {
    if(navbar.classList.contains('scrolled')){
        $('.dropdown-menu').removeClass('dropdown-menu-scroll');
        $('.dropdown-menu').addClass('dropdown-menu-scroll');
    }
    else{
        $('.dropdown-menu').removeClass('dropdown-menu-scroll');
        $('.dropdown-menu').addClass('dropdown-menu-default');
    }
})
observer.observe(navbar, {attributes: true});