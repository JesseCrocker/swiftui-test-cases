# Bug displaying sheets

This was an investigation in what happens when a view that is displaying a sheet is removed from the view heirarchy and replaced with another view that immediately displays a sheet.
I was expecting the 2nd sheet to ignore `.presentationDetents` and `presentationDragIndicator` values. That is not what happened, but another bug was identified.

## isPresented not set to false

### Steps to reproduce

1. Open the app
2. Click show sheet 1
3. Click either "Show container 2 with dismiss" or "Show container 2 without dismiss"
4. tap outside of sheet, or swipe down to dismiss sheet 2.

Expected Behavior: Screen should display "sheet2 = false"

Actual Behavior: it still displays "sheet2 = true"

5. Click "show sheet 2"

Expected behavior: Sheet 2 shows

Actual behavior: nothing happens



### Workaround

The workaround for this is to not initally set `sheet2 = true`, but set `sheet2 = false` and add

```
.onAppear {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        sheet2 = true
    }
}
```

