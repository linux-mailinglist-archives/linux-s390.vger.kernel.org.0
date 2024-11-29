Return-Path: <linux-s390+bounces-7222-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6729D46C8
	for <lists+linux-s390@lfdr.de>; Thu, 21 Nov 2024 05:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4954DB237BF
	for <lists+linux-s390@lfdr.de>; Thu, 21 Nov 2024 04:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222DE80034;
	Thu, 21 Nov 2024 04:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wjod+LTM"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0812DD88
	for <linux-s390@vger.kernel.org>; Thu, 21 Nov 2024 04:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163447; cv=none; b=M1qwjcarE4+mFO+qCbN/uB2m/Ru8K06+d6n6I9BNlMv8JD0a9bx0JIBhOk7qZ7LM5P4OPksg5JfgWu8mDcWRK1whlsZ8P8JPkw8atCptYFxg54HTyMj2P2mSev1VNMgUsMmGp0FNGAjZgsB2V/JE5sAhyx3E9oNxCVyrjOEBBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163447; c=relaxed/simple;
	bh=jWBs3NnSTOjK3J8EnQyfYA9dgj0lOTaKtfBS7xEb0Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Npx8pqI3aCbdunRR1E+ZKgNWQ/zpIAgg+ytWywZl4V7F6jdEMCy6tdXBgi5k+YA3enk1AUud8C6AUSSWaTR0T4yb2vXaZ6T+7yFt1G5Yb4WtTK55SY3emHC1QT4oTk8NL7ni6sUQrOb4+VgtrjkVBA1PnK06bZteW3iA26tzFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wjod+LTM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732163443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1oRBVeUrG/30shRvr2+oS14u3aaQZd0tcZcIHNfuOZU=;
	b=Wjod+LTMfdmQY8c2o0GzbDyt8dI8dqSufKkYESuM+k4xrvECLBJPHR4n30NbWyu+80yS48
	9dAfxP7dd0t5rMsC+HrI2mcEKT4GNwSBlmMK+9N/bfZfJa2f3dJwQJ8sMH9ZWHyelcJfgC
	0PUr8jk1e99Dfe2uvLpM7yjpkT2TCR0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-vNatiTkcPDWezXWdS3a--g-1; Wed,
 20 Nov 2024 23:30:42 -0500
X-MC-Unique: vNatiTkcPDWezXWdS3a--g-1
X-Mimecast-MFC-AGG-ID: vNatiTkcPDWezXWdS3a--g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89EE219560B1;
	Thu, 21 Nov 2024 04:30:39 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 361E81956086;
	Thu, 21 Nov 2024 04:30:36 +0000 (UTC)
Date: Thu, 21 Nov 2024 12:30:32 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 07/11] fs/proc/vmcore: introduce
 PROC_VMCORE_DEVICE_RAM to detect device RAM ranges in 2nd kernel
Message-ID: <Zz63aGL7NcrONk+p@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-8-david@redhat.com>
 <Zz22ZidsMqkafYeg@MiWiFi-R3L-srv>
 <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
 <Zz3sm+BhCrTO3bId@MiWiFi-R3L-srv>
 <3ed18ba1-e4b1-461e-a3a7-5de2df59ca60@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ed18ba1-e4b1-461e-a3a7-5de2df59ca60@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/20/24 at 03:39pm, David Hildenbrand wrote:
> On 20.11.24 15:05, Baoquan He wrote:
> > On 11/20/24 at 11:48am, David Hildenbrand wrote:
> > > On 20.11.24 11:13, Baoquan He wrote:
> > > > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > > > s390 allocates+prepares the elfcore hdr in the dump (2nd) kernel, not in
> > > > > the crashed kernel.
> > > > > 
> > > > > RAM provided by memory devices such as virtio-mem can only be detected
> > > > > using the device driver; when vmcore_init() is called, these device
> > > > > drivers are usually not loaded yet, or the devices did not get probed
> > > > > yet. Consequently, on s390 these RAM ranges will not be included in
> > > > > the crash dump, which makes the dump partially corrupt and is
> > > > > unfortunate.
> > > > > 
> > > > > Instead of deferring the vmcore_init() call, to an (unclear?) later point,
> > > > > let's reuse the vmcore_cb infrastructure to obtain device RAM ranges as
> > > > > the device drivers probe the device and get access to this information.
> > > > > 
> > > > > Then, we'll add these ranges to the vmcore, adding more PT_LOAD
> > > > > entries and updating the offsets+vmcore size.
> > > > > 
> > > > > Use Kconfig tricks to include this code automatically only if (a) there is
> > > > > a device driver compiled that implements the callback
> > > > > (PROVIDE_PROC_VMCORE_DEVICE_RAM) and; (b) the architecture actually needs
> > > > > this information (NEED_PROC_VMCORE_DEVICE_RAM).
> > > > > 
> > > > > The current target use case is s390, which only creates an elf64
> > > > > elfcore, so focusing on elf64 is sufficient.
> > > > > 
> > > > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > > > ---
> > > > >    fs/proc/Kconfig            |  25 ++++++
> > > > >    fs/proc/vmcore.c           | 156 +++++++++++++++++++++++++++++++++++++
> > > > >    include/linux/crash_dump.h |   9 +++
> > > > >    3 files changed, 190 insertions(+)
> > > > > 
> > > > > diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> > > > > index d80a1431ef7b..1e11de5f9380 100644
> > > > > --- a/fs/proc/Kconfig
> > > > > +++ b/fs/proc/Kconfig
> > > > > @@ -61,6 +61,31 @@ config PROC_VMCORE_DEVICE_DUMP
> > > > >    	  as ELF notes to /proc/vmcore. You can still disable device
> > > > >    	  dump using the kernel command line option 'novmcoredd'.
> > > > > +config PROVIDE_PROC_VMCORE_DEVICE_RAM
> > > > > +	def_bool n
> > > > > +
> > > > > +config NEED_PROC_VMCORE_DEVICE_RAM
> > > > > +	def_bool n
> > > > > +
> > > > > +config PROC_VMCORE_DEVICE_RAM
> > > > > +	def_bool y
> > > > > +	depends on PROC_VMCORE
> > > > > +	depends on NEED_PROC_VMCORE_DEVICE_RAM
> > > > > +	depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
> > > > 
> > > > Kconfig item is always a thing I need learn to master.
> > > 
> > > Yes, it's usually a struggle to get it right. It took me a couple of
> > > iterations to get to this point :)
> > > 
> > > > When I checked
> > > > this part, I have to write them down to deliberate. I am wondering if
> > > > below 'simple version' works too and more understandable. Please help
> > > > point out what I have missed.
> > > > 
> > > > ===========simple version======
> > > > config PROC_VMCORE_DEVICE_RAM
> > > >           def_bool y
> > > >           depends on PROC_VMCORE && VIRTIO_MEM
> > > >           depends on NEED_PROC_VMCORE_DEVICE_RAM
> > > > 
> > > > config S390
> > > >           select NEED_PROC_VMCORE_DEVICE_RAM
> > > > ============
> > 
> > Sorry, things written down didn't correctly reflect them in my mind.
> > 
> > ===========simple version======
> > fs/proc/Kconfig:
> > config PROC_VMCORE_DEVICE_RAM
> >          def_bool y
> >          depends on PROC_VMCORE && VIRTIO_MEM
> >          depends on NEED_PROC_VMCORE_DEVICE_RAM
> > config NEED_PROC_VMCORE_DEVICE_RAM
> >          def y
> > 
> > arch/s390/Kconfig:
> > config NEED_PROC_VMCORE_DEVICE_RAM
> >          def y
> > ==================================
> 
> That would work, but I don't completely like it.
> 
> (a) I want s390x to select NEED_PROC_VMCORE_DEVICE_RAM instead. Staring at a
> bunch of similar cases (git grep "config NEED" | grep Kconfig, git grep
> "config ARCH_WANTS" | grep Kconfig), "select" is the common way to do it.
> 
> So unless there is a pretty good reason, I'll keep
> NEED_PROC_VMCORE_DEVICE_RAM as is.

That's easy to satify, see below:

============simple version=====
fs/proc/Kconfig:
config NEED_PROC_VMCORE_DEVICE_RAM
        def n

config PROC_VMCORE_DEVICE_RAM
        def_bool y
        depends on PROC_VMCORE && VIRTIO_MEM
        depends on NEED_PROC_VMCORE_DEVICE_RAM

arch/s390/Kconfig:
config S390
        select NEED_PROC_VMCORE_DEVICE_RAM
==============================

> 
> (b) In the context of this patch, "depends on VIRTIO_MEM" does not make
> sense. We could have an intermediate:
> 
> config PROC_VMCORE_DEVICE_RAM
>          def_bool n
>          depends on PROC_VMCORE
>          depends on NEED_PROC_VMCORE_DEVICE_RAM
> 
> And change that with VIRTIO_MEM support in the relevant patch.

Oh, it's not comment for this patch, I made the simple version based on
the whole patchset. When I had a glance at this patch, I also took
several iterations to get it after I applied the whole patchset and
tried to understand the whole code.

> 
> 
> I faintly remember that we try avoiding such dependencies and prefer
> selecting Kconfigs instead. Just look at the SPLIT_PTE_PTLOCKS mess we still
> have to clean up. But as we don't expect that many providers for now, I
> don't care.

With the simple version, Kconfig learner as me can easily understand what
they are doing. If it took you a couple of iterations to make them as
you had mentioned earlier, and it took me several iterations to
understand them, I believe there must be room to improve the presented
ones in this patchset. These are only my humble opinion, and I am not
aware of virtio-mem at all, I'll leave this to you and other virtio-mem
dev to decide what should be taken. Thanks for your patience and
provided information, I learned a lot from this discussion.

===================
fs/proc/Kconfig:
config PROVIDE_PROC_VMCORE_DEVICE_RAM
        def_bool n

config NEED_PROC_VMCORE_DEVICE_RAM
        def_bool n

config PROC_VMCORE_DEVICE_RAM
        def_bool y
        depends on PROC_VMCORE
        depends on NEED_PROC_VMCORE_DEVICE_RAM
        depends on PROVIDE_PROC_VMCORE_DEVICE_RAM

drivers/virtio/Kconfig:
config VIRTIO_MEM
        select PROVIDE_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
                                              ~~~~~~~~~~~~~~

arch/s390/Kconfig:
config S390
        select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
                                           ~~~~~~~~~~~~~~
========================

One last thing I haven't got well, If PROC_VMCORE_DEVICE_RAM has had
dependency on PROC_VMCORE, can we take off the ' if PROC_VMCORE' when
select PROVIDE_PROC_VMCORE_DEVICE_RAM and NEED_PROC_VMCORE_DEVICE_RAM?

Thanks
Baoquan


