Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C060E1F1C1F
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2020 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgFHPbH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Jun 2020 11:31:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgFHPbG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 11:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=xR2f824jyeDcek+juhYa40ZCw3TUqH2Eo9g1XqCPz98=;
        b=NXsLZvLm7CQR6Y/kSkdw1ZpbDxT7or9ZUvy7h2Nu+weTQAPoo/fcOnQ7EFjmH9xyEJYX09
        tAljtsW7kbHP0lWpuDvBnS1fACfJ+zRGfsZ24HSAjlaFrj6ujE9wy8Ejo7it3g2301wqAU
        Wo72ROmbzvqWkMWdkKwJWNiiGyhIasU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-z2MvpZsmPDuQpqpZEhP0Lw-1; Mon, 08 Jun 2020 11:31:01 -0400
X-MC-Unique: z2MvpZsmPDuQpqpZEhP0Lw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB2A31083E81;
        Mon,  8 Jun 2020 15:30:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-119.ams2.redhat.com [10.36.112.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5CB860C47;
        Mon,  8 Jun 2020 15:30:55 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v8 01/12] s390x: Use PSW bits definitions
 in cstart
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-2-git-send-email-pmorel@linux.ibm.com>
 <59f3dda9-6cd1-a3b4-5265-1a9fb2ff51ed@redhat.com>
 <e03cb81c-30cc-7cbc-c3a8-cc863a5d0be1@linux.ibm.com>
 <1e51b893-dc1e-1740-f286-ec00195d6a7f@redhat.com>
 <d94b6f43-2250-17ee-e146-1347c0350294@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <77f6ed8f-4b4c-be0f-f29a-429618c9e3c0@redhat.com>
Date:   Mon, 8 Jun 2020 17:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d94b6f43-2250-17ee-e146-1347c0350294@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08/06/2020 17.28, Pierre Morel wrote:
> 
> 
> On 2020-06-08 16:52, Thomas Huth wrote:
>> On 08/06/2020 16.33, Pierre Morel wrote:
>>>
>>>
>>> On 2020-06-08 10:43, Thomas Huth wrote:
>>>> On 08/06/2020 10.12, Pierre Morel wrote:
>>>>> This patch defines the PSW bits EA/BA used to initialize the PSW masks
>>>>> for exceptions.
>>>>>
>>>>> Since some PSW mask definitions exist already in arch_def.h we add
>>>>> these
>>>>> definitions there.
>>>>> We move all PSW definitions together and protect assembler code
>>>>> against
>>>>> C syntax.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>    lib/s390x/asm/arch_def.h | 15 +++++++++++----
>>>>>    s390x/cstart64.S         | 15 ++++++++-------
>>>>>    2 files changed, 19 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>>>>> index 1b3bb0c..5388114 100644
>>>>> --- a/lib/s390x/asm/arch_def.h
>>>>> +++ b/lib/s390x/asm/arch_def.h
>>>>> @@ -10,15 +10,21 @@
>>>>>    #ifndef _ASM_S390X_ARCH_DEF_H_
>>>>>    #define _ASM_S390X_ARCH_DEF_H_
>>>>>    +#define PSW_MASK_EXT            0x0100000000000000UL
>>>>> +#define PSW_MASK_DAT            0x0400000000000000UL
>>>>> +#define PSW_MASK_SHORT_PSW        0x0008000000000000UL
>>>>> +#define PSW_MASK_PSTATE            0x0001000000000000UL
>>>>> +#define PSW_MASK_BA            0x0000000080000000UL
>>>>> +#define PSW_MASK_EA            0x0000000100000000UL
>>>>> +
>>>>> +#define PSW_EXCEPTION_MASK    (PSW_MASK_EA | PSW_MASK_BA)
>>>>
>>>> PSW_EXCEPTION_MASK sounds a little bit unfortunate - that term rather
>>>> reminds me of something that disables some interrupts
>>>> ... in case you
>>>> respin, maybe rather use something like "PSW_EXC_ADDR_MODE" ?
>>>
>>> EXCEPTIONS_PSW_MASK ?
>>
>> I think it is the _MASK suffix that mainly bugs me here, since this is
>> not a define that you normally use for extracting the bits from a PSW...
>> so EXCEPTIONS_PSW without _MASK would be fine for me... but as long as
>> I'm the only one who has a strange feeling about this, it's also ok if
>> you keep the current name.
>>
>>   Thomas
>>
> 
> The _MASK is because it is applied to the psw.mask and not to the
> psw.addr part.
> 
> But I agree that the name is not good, to keep the naming convention,
> may be it should be:
> 
> PSW_MASK_ON_EXCEPTION
> 
> beginning with PSW_MASK_ like all other psw.mask definitions and
> ON_EXCEPTION clearly define when it is used.

Good idea, PSW_MASK_ON_EXCEPTION sounds better for me, too!

 Thomas

