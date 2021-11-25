tweenTimelineDestroy(tlGameSpeed);
tweenTimelineDestroy(tlPlayerX);

// Destroy system (and associated emitters)
part_system_destroy(windParticleSystem);
part_type_destroy(windParticle);