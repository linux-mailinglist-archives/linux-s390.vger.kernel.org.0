Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB5B0B2E
	for <lists+linux-s390@lfdr.de>; Thu, 12 Sep 2019 11:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfILJUb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Sep 2019 05:20:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730175AbfILJUb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 05:20:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BB4F8A218D;
        Thu, 12 Sep 2019 09:20:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-204-41.brq.redhat.com [10.40.204.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C07031001B08;
        Thu, 12 Sep 2019 09:20:25 +0000 (UTC)
Subject: Re: [PATCH] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
To:     David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190912090050.20295-1-thuth@redhat.com>
 <6905df78-95f0-3d6d-aaae-910cd2d7a232@redhat.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <253e67f6-0a41-13e8-4ca2-c651d5fcdb69@redhat.com>
Date:   Thu, 12 Sep 2019 11:20:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6905df78-95f0-3d6d-aaae-910cd2d7a232@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 12 Sep 2019 09:20:30 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/09/2019 11.14, David Hildenbrand wrote:
> On 12.09.19 11:00, Thomas Huth wrote:
>> When the userspace program runs the KVM_S390_INTERRUPT ioctl to inject
>> an interrupt, we convert them from the legacy struct kvm_s390_interrupt
>> to the new struct kvm_s390_irq via the s390int_to_s390irq() function.
>> However, this function does not take care of all types of interrupts
>> that we can inject into the guest later (see do_inject_vcpu()). Since we
>> do not clear out the s390irq values before calling s390int_to_s390irq(),
>> there is a chance that we copy unwanted data from the kernel stack
>> into the guest memory later if the interrupt data has not been properly
>> initialized by s390int_to_s390irq().
>>
>> Specifically, the problem exists with the KVM_S390_INT_PFAULT_INIT
>> interrupt: s390int_to_s390irq() does not handle it, but the function
>> __deliver_pfault_init() will later copy the uninitialized stack data
>> from the ext.ext_params2 into the guest memory.
>>
>> Fix it by handling that interrupt type in s390int_to_s390irq(), too.
>> And while we're at it, make sure that s390int_to_s390irq() now
>> directly returns -EINVAL for unknown interrupt types, so that we
>> do not run into this problem again in case we add more interrupt
>> types to do_inject_vcpu() sometime in the future.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  arch/s390/kvm/interrupt.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 3e7efdd9228a..165dea4c7f19 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -1960,6 +1960,16 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
>>  	case KVM_S390_MCHK:
>>  		irq->u.mchk.mcic = s390int->parm64;
>>  		break;
>> +	case KVM_S390_INT_PFAULT_INIT:
>> +		irq->u.ext.ext_params = s390int->parm;
>> +		irq->u.ext.ext_params2 = s390int->parm64;
>> +		break;
>> +	case KVM_S390_RESTART:
>> +	case KVM_S390_INT_CLOCK_COMP:
>> +	case KVM_S390_INT_CPU_TIMER:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>>  	}
>>  	return 0;
>>  }
>>
> 
> Wouldn't a safe fix be to initialize the struct to zero in the caller?

That's of course possible, too. But that means that we always have to
zero out the whole structure, so that's a little bit more of overhead
(well, it likely doesn't matter for such a legacy ioctl).

But the more important question: Do we then still care of fixing the
PFAULT_INIT interrupt here? Since it requires a parameter, the "case
KVM_S390_INT_PFAULT_INIT:" part would be required here anyway.

 Thomas
