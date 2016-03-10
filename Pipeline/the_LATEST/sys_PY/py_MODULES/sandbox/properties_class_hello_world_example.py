class MyClass(object):
	def __init__(self):
		super(MyClass, self).__init__()
	# end __init__
	@property
	def foo(self):
		return self._foo
	# end foo.property
	@foo.setter
	def foo(self, value):
		self._foo = value
	# end foo.setter
	# end foo
# end MyClass


cls = MyClass()
cls.foo = True
print cls.foo
cls.foo = False
print cls.foo