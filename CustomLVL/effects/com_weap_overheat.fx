ParticleEmitter("Smoke")
{
	MaxParticles(20.0000,20.0000);
	StartDelay(0.0000,0.0000);
	BurstDelay(0.1000, 0.1500);
	BurstCount(1.0000,1.0000);
	MaxLodDist(50.0000);
	MinLodDist(10.0000);
	SoundName("")
	Size(1.0000, 1.0000);
	Hue(255.0000, 255.0000);
	Saturation(255.0000, 255.0000);
	Value(255.0000, 255.0000);
	Alpha(255.0000, 255.0000);
	Spawner()
	{
		Spread()
		{
			PositionX(0.0000,0.0000);
			PositionY(0.0500,0.2000);
			PositionZ(0.0000,0.0000);
		}
		Offset()
		{
			PositionX(0.0000,0.0000);
			PositionY(0.0000,0.0000);
			PositionZ(0.0000,0.0000);
		}
		PositionScale(0.0000,0.0000);
		VelocityScale(2.0000,2.0000);
		InheritVelocityFactor(0.0000,0.0000);
		Size(0, 0.0500, 0.1500);
		Red(0, 200.0000, 200.0000);
		Green(0, 200.0000, 200.0000);
		Blue(0, 200.0000, 200.0000);
		Alpha(0, 0.0000, 0.0000);
		StartRotation(0, 0.0000, 360.0000);
		RotationVelocity(0, -20.0000, 20.0000);
		FadeInTime(0.0000);
	}
	Transformer()
	{
		LifeTime(3.0000);
		Position()
		{
			LifeTime(3.0000)
			Accelerate(0.1000, -0.2000, 0.1000);
		}
		Size(0)
		{
			LifeTime(3.0000)
			Scale(1.5000);
		}
		Color(0)
		{
			LifeTime(1.0000)
			Move(200.0000,200.0000,200.0000,16.0000);
			Next()
			{
				LifeTime(2.0000)
				Move(0.0000,0.0000,0.0000,-170.0000);
			}
		}
	}
	Geometry()
	{
		BlendMode("NORMAL");
		Type("PARTICLE");
		Texture("thicksmoke2");
	}
}
