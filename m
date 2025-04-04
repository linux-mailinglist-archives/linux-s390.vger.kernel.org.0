Return-Path: <linux-s390+bounces-9789-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE40AA7BB3F
	for <lists+linux-s390@lfdr.de>; Fri,  4 Apr 2025 12:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41153B491A
	for <lists+linux-s390@lfdr.de>; Fri,  4 Apr 2025 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0150C33997;
	Fri,  4 Apr 2025 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4qmVvJG"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DC1C6FF0
	for <linux-s390@vger.kernel.org>; Fri,  4 Apr 2025 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764118; cv=none; b=RFiqRv6YEfRzrVeDEja8C/HiVlF9zOpGuxuyOUqOKmDLC41ijUy+k9n5NOnzKC68SjfA2ZA9oxGFuTBeB7LE4Fa6drYeuO8YjFS9/McsKJ9/9qlMKmPKKu42CnMrZG05u5TUnTsNO35dF+xr+w1fHUgMHy7QaBNhh+4LSxlfZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764118; c=relaxed/simple;
	bh=IZYN6qklL/9V0fiJDhYT3oM3axpVyV6yOc19ZY4wP9k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XM9vn61avmpiMedvXFp1i05pbRZQu4b5CXZgdSYMdajdfKmM7K1Ys9kE+sMoqMixUa6woB379I0VxW6LXBMeEn1bOgpOUXFsBnk/lkFkw4vNc+evxfQ9O+sR8Oo0MDVLXRoz+wigzjkWbVyoUzNAU02nflTpaJOuvBpj4yznGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4qmVvJG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743764114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ic6HVcaclyt2+GiS0pcmiLzMysp98kqPu1Z6KM2GgNs=;
	b=T4qmVvJGkbreNEPOU/dieKVfLOz9hQlvx22E9kBgY7hVVatUcIsZpJwNnlRZALwTyudtFX
	o5U0VH8EBdgHg1IsVIOiUVNwRdXGjFbxNEj9RUC/8NxfvcL7oNxffBk2+hQSjqxpWW9Wjg
	7cTL62/MeXUw7fgPsAle7Md658tid5Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-Z1wYcb7rNBmY_j-x4PhXxw-1; Fri, 04 Apr 2025 06:55:13 -0400
X-MC-Unique: Z1wYcb7rNBmY_j-x4PhXxw-1
X-Mimecast-MFC-AGG-ID: Z1wYcb7rNBmY_j-x4PhXxw_1743764112
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso1362030f8f.2
        for <linux-s390@vger.kernel.org>; Fri, 04 Apr 2025 03:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743764112; x=1744368912;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ic6HVcaclyt2+GiS0pcmiLzMysp98kqPu1Z6KM2GgNs=;
        b=SkBxmrPWVVpz6fZiNydAGyuaGX5HcMw53A2ajP0Wu9gF21ou8QDiuEz2VOpSaMDTHG
         k5SecJs8tV7nHTFmuv5hzwAR/C5DClyp6DammJDWRukWk+ZV9CiD0B6IeOtUua5+aGEV
         KRmyY/j1QMOKB3zDkS8dVrHpZtRXLgD+wABZ5+e+jrxMUOVRXKTaCokWwmew7zYkX3Vr
         +wN94mIe7WiReHFFguGv2vBFP9otg/7IZF6h0WT42lvbxaRz53LJG4ASqikQTs07DudG
         Zn94WCpAGJLOVQjqimC0BXe/p5AcTUe5Md3Miyg7Gd24fQtOq4oKgIOt9zcGJZdwq67s
         U4+g==
X-Forwarded-Encrypted: i=1; AJvYcCWdcisuktsuBaaqojOeGfzHr6ibXvs9YXQNfi1Ls92eJy/3wNgr7PaVWNApsxhPeh7Bs7GaFoaULPQ9@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2myUy5Xwq7k58JD6miMN8n+b7gGv1i6TEa6pc+qVIVIwv5mP
	ZJSA48hCqtrRX3HeHyUGYDzj0zURM694whI3iq8ZtC02yAXF04HXJmOZ2vf25x7v6m0exeKMLvX
	y6yceOXbZypOckrCwPX4joTdB3QVYO9adnjkz/Ar1QuQN6HII4NgdPFmfA2k=
X-Gm-Gg: ASbGncuPXqIKkC+RjjcVhT+eS03RZqdll9ZVcM3mUeW4L2XmrYfqSB+W1TavuNA626T
	jNkjpzy4M28EFLZhCrcmq/hkn7O5jCNu0Ap0Bkii5coFZgkPuqUo8fLLA++8CLfXfPCnzQGI/s/
	3DOLEjW6/boPsKRPJTW9EYu2pLXg4OqaQJv3HmwWU5+COssAuDqJXmLbqNH6gS7KR+7sPGKGcB4
	4KMPxh98Z5g+MV63aEYC/cNYFHTta8SH/aDAIHsAiV3NdtporypnXTA261WyhxUGbFMCEgFg65D
	telrdVjlt2LdRTPCeO7m4BP5qnGObw+U2+Q7DkzZXu2dQtdoves9fZe3cKAvpjXN59Dvm5pymz+
	USSItftY6BriNwVvOoCrmQB3G9yxfmaMo0ggiNk6PPNg=
X-Received: by 2002:a5d:59ad:0:b0:391:4835:d888 with SMTP id ffacd0b85a97d-39cba93686bmr2215462f8f.42.1743764111823;
        Fri, 04 Apr 2025 03:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8NXj7jCxAl5AboVs8euv93UQZHB5kglneNiYLdDVpaoZ76r+FokGIEfRt6KRn5EKmsslUcQ==
X-Received: by 2002:a5d:59ad:0:b0:391:4835:d888 with SMTP id ffacd0b85a97d-39cba93686bmr2215432f8f.42.1743764111375;
        Fri, 04 Apr 2025 03:55:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d661sm4168103f8f.66.2025.04.04.03.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:55:10 -0700 (PDT)
Message-ID: <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
Date: Fri, 4 Apr 2025 12:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
From: David Hildenbrand <david@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.25 12:00, David Hildenbrand wrote:
> On 04.04.25 06:36, Halil Pasic wrote:
>> On Thu, 3 Apr 2025 16:28:31 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>>> Sorry I have to have a look at that discussion. Maybe it will answer
>>>> some my questions.
>>>
>>> Yes, I think so.
>>>
>>>>     
>>>>> Let's fix it without affecting existing setups for now by properly
>>>>> ignoring the non-existing queues, so the indicator bits will match
>>>>> the queue indexes.
>>>>
>>>> Just one question. My understanding is that the crux is that Linux
>>>> and QEMU (or the driver and the device) disagree at which index
>>>> reporting_vq is actually sitting. Is that right?
>>>
>>> I thought I made it clear: this is only about the airq indicator bit.
>>> That's where both disagree.
>>>
>>> Not the actual queue index (see above).
>>
>> I did some more research including having a look at that discussion. Let
>> me try to sum up how did we end up here.
> 
> Let me add some more details after digging as well:
> 
>>
>> Before commit a229989d975e ("virtio: don't allocate vqs when names[i] =
>> NULL") the kernel behavior used to be in spec, but QEMU and possibly
>> other hypervisor were out of spec and things did not work.
> 
> It all started with VIRTIO_BALLOON_F_FREE_PAGE_HINT. Before that,
> we only had the single optional VIRTIO_BALLOON_F_STATS_VQ queue at the very
> end. So there was no possibility for holes "in-between".
> 
> In the Linux driver, we created the stats queue only if the feature bit
> VIRTIO_BALLOON_F_STATS_VQ was actually around:
> 
> 	nvqs = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ) ? 3 : 2;
> 	err = virtio_find_vqs(vb->vdev, nvqs, vqs, callbacks, names, NULL);
> 
> That changed with VIRTIO_BALLOON_F_FREE_PAGE_HINT, because we would
> unconditionally create 4 queues. QEMU always supported the first 3 queues
> unconditionally, but old QEMU did obviously not support the (new)
> VIRTIO_BALLOON_F_FREE_PAGE_HINT queue.
> 
> 390x didn't particularly like getting queried for non-existing
> queues. [1] So the fix was not for a hypervisor that was out of spec, but
> because quering non-existing queues didn't work.
> 
> The fix implied that if VIRTIO_BALLOON_F_STATS_VQ is missing, suddenly the queue
> index of VIRTIO_BALLOON_F_FREE_PAGE_HINT changed as well.
> 
> Again, as QEMU always implemented the 3 first queues unconditionally, this was
> not a problem.
> 
> [1] https://lore.kernel.org/all/c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com/#t
> 
>>
>> Possibly because of the complexity of fixing the hypervisor(s) commit
>> a229989d975e ("virtio: don't allocate vqs when names[i] = NULL") opted
>> for changing the guest side so that it does not fit the spec but fits
>> the hypervisor(s). It unfortunately also broke notifiers (for the with
>> holes) scenario for virtio-ccw only.
> 
> Yes, it broke the notifiers.
> 
> But note that everything was in spec at that point, because we only documented
> "free_page_vq == 3" in the spec *2 years later*, in 2020:
> 
> commit 38448268eba0c105200d131c3f7f660129a4d673
> Author: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Date:   Tue Aug 25 07:45:02 2020 -0700
> 
>       content: Document balloon feature free page hints
>       
>       Free page hints allow the balloon driver to provide information on what
>       pages are not currently in use so that we can avoid the cost of copying
>       them in migration scenarios. Add a feature description for free page hints
>       describing basic functioning and requirements.
>       
> At that point, what we documented in the spec *did not match reality* in
> Linux. QEMU was fully compatible, because VIRTIO_BALLOON_F_STATS_VQ is
> unconditionally set.
> 
> 
> QEMU and Linux kept using that queue index assignment model, and the spec
> was wrong (out of sync?) at that point. The spec got more wrong with
> 
> commit d917d4a8d552c003e046b0e3b1b529d98f7e695b
> Author: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Date:   Tue Aug 25 07:45:17 2020 -0700
> 
>       content: Document balloon feature free page reporting
>       
>       Free page reporting is a feature that allows the guest to proactively
>       report unused pages to the host. By making use of this feature is is
>       possible to reduce the overall memory footprint of the guest in cases where
>       some significant portion of the memory is idle. Add documentation for the
>       free page reporting feature describing the functionality and requirements.
> 
> Where we documented VIRTIO_BALLOON_F_REPORTING after the changes were added to
> QEMU+Linux implementation, so the spec did not reflect reality.
> 
> I'll note also cloud-hypervisor [2] today follows that model.
> 
> In particular, it *only* supports VIRTIO_BALLOON_F_REPORTING, turning
> the queue index of VIRTIO_BALLOON_F_REPORTING into *2* instead of documented
> in the spec to be *4*.
> 
> So in reality, we can see VIRTIO_BALLOON_F_REPORTING to be either 2/3/4, depending
> on the availability of the other two features/queues.
> 
> [2] https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/virtio-devices/src/balloon.rs
> 
> 
>>
>> Now we had another look at this, and have concluded that fixing the
>> hypervisor(s) and fixing the kernel, and making sure that the fixed
>> kernel can tolerate the old broken hypervisor(s) is way to complicated
>> if possible at all. So we decided to give the spec a reality check and
>> fix the notifier bit assignment for virtio-ccw which is broken beyond
>> doubt if we accept that the correct virtqueue index is the one that the
>> hypervisor(s) use and not the one that the spec says they should use.
> 
> In case of virtio-balloon, it's unfortunate that it went that way, but the
> spec simply did not / does not reflect reality when it was added to the spec.
> 
>>
>> With the spec fixed, the whole notion of "holes" will be something that
>> does not make sense any more. With that the merit of the kernel interface
>> virtio_find_vqs() supporting "holes" is quite questionable. Now we need
>> it because the drivers within the Linux kernel still think of the queues
>> in terms of the current spec, i.e. they try to have the "holes" as
>> mandated by the spec, and the duty of making it work with the broken
>> device implementations falls to the transports.
>>
> 
> Right, the "holes" only exist in the input array.
> 
>> Under the assumption that the spec is indeed going to be fixed:

For virito-balloon, we should probably do the following:

 From 38e340c2bb53c2a7cc7c675f5dfdd44ecf7701d9 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 4 Apr 2025 12:53:16 +0200
Subject: [PATCH] virtio-balloon: Fix queue index assignment for
  non-existing queues

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  device-types/balloon/description.tex | 22 ++++++++++++++++------
  1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/device-types/balloon/description.tex b/device-types/balloon/description.tex
index a1d9603..a7396ff 100644
--- a/device-types/balloon/description.tex
+++ b/device-types/balloon/description.tex
@@ -16,6 +16,21 @@ \subsection{Device ID}\label{sec:Device Types / Memory Balloon Device / Device I
    5
  
  \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtqueues}
+
+\begin{description}
+\item[inflateq] Exists unconditionally.
+\item[deflateq] Exists unconditionally.
+\item[statsq] Only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
+\item[free_page_vq] Only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
+\item[reporting_vq] Only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
+\end{description}
+
+\begin{note}
+Virtqueue indexes are assigned sequentially for existing queues, starting
+with index 0; consequently, if a virtqueue does not exist, it does not get
+an index assigned. Assuming all virtqueues exist for a device, the indexes
+are:
+
  \begin{description}
  \item[0] inflateq
  \item[1] deflateq
@@ -23,12 +38,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
  \item[3] free_page_vq
  \item[4] reporting_vq
  \end{description}
-
-  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
-
-  free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
-
-  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
+\end{note}
  
  \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
  \begin{description}
-- 
2.48.1


If something along these lines sounds reasonable, I can send a proper patch to the
proper audience.

-- 
Cheers,

David / dhildenb


