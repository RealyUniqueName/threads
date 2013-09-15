package usys.vm;


typedef Mutex = #if cpp cpp.vm.Mutex #else neko.vm.Mutex #end ;