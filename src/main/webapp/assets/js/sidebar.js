// Create an aside element
const asideElement = document.createElement('aside');

// Create a paragraph element for the menu title
const logoSection = document.createElement('div');
logoSection.className = 'logoSection';

// Create a link element for the logo and text
const logoLink = document.createElement('a');
logoLink.href = 'index.jsp';

// Create an image element for the logo
const logoImage = document.createElement('img');
logoImage.src = 'assets/images/favicon.png';
logoImage.alt = 'FreshTime Logo';

// Create a text node for the text
const logoText = document.createTextNode('Freshtime');

// Append the image and text to the link element
logoLink.appendChild(logoImage);
logoLink.appendChild(logoText);

// Append the link element to the paragraph
logoSection.appendChild(logoLink);

// Create anchor element for "My drive"
const myTaskLink = document.createElement('a');
myTaskLink.href = "#";

const myTaskIcon = document.createElement('i');
myTaskIcon.className = 'fa-solid fa-list-check';
myTaskIcon.setAttribute('aria-hidden', 'true');
myTaskLink.appendChild(myTaskIcon);

const myTaskText = document.createTextNode('My Task');
myTaskLink.appendChild(myTaskText);

// Create anchor element for "Computers"
const reportLink = document.createElement('a');
reportLink.href = "#";

const reportIcon = document.createElement('i');
reportIcon.className = 'fa-solid fa-chart-column';
reportIcon.setAttribute('aria-hidden', 'true');
reportLink.appendChild(reportIcon);

const reportText = document.createTextNode('Report');
reportLink.appendChild(reportText);

// Create anchor element for "Shared with me"
const notesLink = document.createElement('a');
notesLink.href = "#";

const notesIcon = document.createElement('i');
notesIcon.className = 'fa fa-clone';
notesIcon.setAttribute('aria-hidden', 'true');
notesLink.appendChild(notesIcon);

const notesText = document.createTextNode('Notes');
notesLink.appendChild(notesText);

// Create anchor element for "Starred"
const profileLink = document.createElement('a');
profileLink.href = "#";

const profileIcon = document.createElement('i');
profileIcon.className = 'fa-solid fa-user-gear';
profileIcon.setAttribute('aria-hidden', 'true');
profileLink.appendChild(profileIcon);

const profileText = document.createTextNode('Profile');
profileLink.appendChild(profileText);



// Append all menu items to the aside element
asideElement.appendChild(logoSection);
asideElement.appendChild(myTaskLink);
asideElement.appendChild(reportLink);
asideElement.appendChild(notesLink);
asideElement.appendChild(profileLink);

// Add the aside element to the main container div with the class "main"
const mainDiv = document.querySelector(".main");
// document.body.appendChild(asideElement);
mainDiv.appendChild(asideElement);

