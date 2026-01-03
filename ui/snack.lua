function simpleSnackMsg(t)
  local mSnackbar = Snackbar.make(activity.findViewById(android.R.id.content),
  ""..t, Snackbar.LENGTH_LONG)
  mSnackbar.setAction("老子知道了", View.OnClickListener{
    onClick = function(v)
      mSnackbar.dismiss()
    end
  })
  mSnackbar.show()
end