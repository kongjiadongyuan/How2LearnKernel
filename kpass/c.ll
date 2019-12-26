; ModuleID = 'c.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.teststruct1 = type { i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define void @go() #0 {
entry:
  %a = alloca i32, align 4
  %t = alloca %struct.teststruct1, align 4
  store i32 0, i32* %a, align 4
  %a1 = getelementptr inbounds %struct.teststruct1, %struct.teststruct1* %t, i32 0, i32 0
  store i32 1, i32* %a1, align 4
  %b = getelementptr inbounds %struct.teststruct1, %struct.teststruct1* %t, i32 0, i32 1
  store i32 1, i32* %b, align 4
  call void (...) bitcast (void ()* @back to void (...)*)()
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @gogo() #0 {
entry:
  call void @go()
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @back() #0 {
entry:
  %t = alloca %struct.teststruct1, align 4
  %b1 = alloca i32, align 4
  %a = getelementptr inbounds %struct.teststruct1, %struct.teststruct1* %t, i32 0, i32 0
  store i32 2, i32* %a, align 4
  %b = getelementptr inbounds %struct.teststruct1, %struct.teststruct1* %t, i32 0, i32 1
  store i32 3, i32* %b, align 4
  store i32 2, i32* %b1, align 4
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0, !0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 6.0.1 (tags/RELEASE_601/final)"}
!1 = !{i32 1, !"wchar_size", i32 4}
