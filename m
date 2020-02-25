Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7771316F296
	for <lists+linux-s390@lfdr.de>; Tue, 25 Feb 2020 23:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgBYW3M (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 25 Feb 2020 17:29:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56882 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726827AbgBYW3L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 17:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582669749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=wdsgKmaoBenOYlPmT+FDhmrFMca+cTnREXlGwbrclNE=;
        b=OuD1uaIrCUqv/P6nA4H7QlLTsksuqd00t4wwuH91Y7R3aW71uTxXGcvHLWGgai7kPqUSUd
        4adugj4bYkf/KpLCScMbxlnIyUJM0XCGjv+d6qJloWgyKS29OvOuQUvdKsLW8eXKopLoQ+
        ha6ngz+E7j8nLR26I7h8FrReiyILnOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-FgxbYuSCMD2rYZ-1sdQzPg-1; Tue, 25 Feb 2020 17:29:05 -0500
X-MC-Unique: FgxbYuSCMD2rYZ-1sdQzPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A941DB22;
        Tue, 25 Feb 2020 22:29:04 +0000 (UTC)
Received: from [10.36.117.12] (ovpn-117-12.ams2.redhat.com [10.36.117.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09392909FC;
        Tue, 25 Feb 2020 22:29:01 +0000 (UTC)
Subject: Re: [PATCH v4 09/36] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michael Mueller <mimu@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-10-borntraeger@de.ibm.com>
 <f80a0b58-5ed2-33b7-5292-2c4899d765b7@redhat.com>
 <24689dd9-139d-3a0b-a57c-9f13ebda142b@de.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <cff6dcbe-7028-c518-e218-426c2d26acb0@redhat.com>
Date:   Tue, 25 Feb 2020 23:29:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <24689dd9-139d-3a0b-a57c-9f13ebda142b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>>
>> The question will repeat a couple of times in the patch: Do we want to
>> convert that to a proper error (e.g., EBUSY, EINVAL, EWHATSOEVER)
>> instead of returning "1" to user space (whoch looks weird).
>=20
> Not sure about the right error code.=20
> -EIO for cc =3D=3D 1?

Makes sense.

[...]

>>> +	if (!cc)
>>> +		free_pages(vcpu->arch.pv.stor_base,
>>> +			   get_order(uv_info.guest_cpu_stor_len));
>>
>> Should we clear arch.pv.handle?
>=20
> this is done in the memset below

missed that, grepping betrayed me.

>>
>> Also, I do wonder if it makes sense to
>>
>> vcpu->arch.pv.stor_base =3D NULL;
>=20
> same. We could do 4 single assignments instead, but the memset is proba=
bly ok?

yes, it's only harder to review ;)

[...]

>>> +	mutex_lock(&kvm->slots_lock);
>>> +	memslot =3D kvm_memslots(kvm)->memslots;
>>> +	npages =3D memslot->base_gfn + memslot->npages;
>>
>> I remember I asked this question already, maybe I missed the reply :(
>>
>> 1. What if we have multiple slots?
>=20
> memslot 0 is the last one, so this should actually have the last memory=
 address
> so this should be ok.

I think I got it wrong (thought there would be some start and length -
but it's only a length, which makes sense).

>=20
>> 2. What is expected to happen if new slots are added (e.g., memory
>> hotplug in the future?)
>>
>> Shouldn't you bail out if there is more than one slot and make sure th=
at
>> no new ones can be added as long as pv is active (I remember the latte=
r
>> should be very easy from an arch callback)?
>=20
> Yes, that should be easy, something like the following I guess
>=20
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4744,6 +4744,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
>         if (mem->guest_phys_addr + mem->memory_size > kvm->arch.mem_lim=
it)
>                 return -EINVAL;
> =20
> +       /* When we are protected we should not change the memory slots =
*/
> +       if (kvm_s390_pv_is_protected(kvm))
> +               return -EINVAL;
>         return 0;
>  }
> =20
>=20
>=20
>=20
> I think we can extend that later to actually use
> the memorysize from kvm->arch.mem_limit as long as this is reasonably s=
mall.
> This should then be done when we implement memory hotplug.

IMHO mem_limit would make a lot of sense and even make hotplug work out
of the box. I assume you can assume that user space properly sets this
up for all PV guests (KVM_S390_VM_MEM_LIMIT_SIZE).

So maybe use that directly and bail out if it's too big? (esp. if it's
KVM_S390_NO_MEM_LIMIT).

[...]

>> Similar to the VCPU path, should be set all pointers to NULL but skip
>> the freeing? With a similar comment /* Inteded memory leak ... */
>=20
> This is done in kvm_s390_pv_dealloc_vm. And I think it makes sense to k=
eep
> the VM thing linked to the KVM struct. This will prevent the user from =
doing
> another PV_ENABLE on this guest.


Makes sense.


--=20
Thanks,

David / dhildenb

