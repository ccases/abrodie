let check_file = (e) => {
  e.preventDefault();
  let file = document.getElementsByTagName("input")[0];

  if !file.value
    alert("No file selected. Please upload a pdf/docx file.");
  else
    e.submit();
}