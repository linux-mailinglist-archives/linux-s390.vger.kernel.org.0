Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7C313BAB4
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jan 2020 09:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAOILc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Jan 2020 03:11:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgAOILc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jan 2020 03:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579075891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=tFZeNObk7oeouUzPHZik28njMFGVvPSA5D3yTdzixIg=;
        b=Mq5Fhe8MJ1fkgt9X4vC3pH2miBPwbzKQ+eoRqJ+b+UqJsbCt540syux8wLgsSP6pwsOA/X
        734cRLqoZ3pDIcVA/t15zncO8DC+nao/OjP6J7AvKlnkswIvgrNoZTM2EIl1PcLX18ty6a
        zqNQaJQwMYPq/aVUDe9H14XP/7JJ+X8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-U0CrBkYsM5qdd4hABQlXJg-1; Wed, 15 Jan 2020 03:11:27 -0500
X-MC-Unique: U0CrBkYsM5qdd4hABQlXJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DD2E107ACE4;
        Wed, 15 Jan 2020 08:11:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0836019C5B;
        Wed, 15 Jan 2020 08:11:21 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 3/4] s390x: smp: Test all CRs on initial
 reset
To:     Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-4-frankja@linux.ibm.com>
 <2f190b0a-e403-51e6-27da-7f8f1f6289ac@de.ibm.com>
 <f120ad03-aab1-a863-636b-b11898d634f5@redhat.com>
 <3ee92240-56dc-69af-4fca-a4a2156e7749@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <eb8bc589-9efa-f512-34f5-2c4c860106a3@redhat.com>
Date:   Wed, 15 Jan 2020 09:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3ee92240-56dc-69af-4fca-a4a2156e7749@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 15/01/2020 08.57, Janosch Frank wrote:
> On 1/15/20 7:17 AM, Thomas Huth wrote:
>> On 14/01/2020 19.42, Christian Borntraeger wrote:
>>>
>>>
>>> On 14.01.20 16:30, Janosch Frank wrote:
>>>> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
>>>> so we also need to test 1-13 and 15 for 0.
>>>>
>>>> And while we're at it, let's also set some values to cr 1, 7 and 13, so
>>>> we can actually be sure that they will be zeroed.
>>>
>>> While it does not hurt to have it here, I think the register check for the reset
>>> would be better in a kselftest. This allows to check userspace AND guest at the
>>> same time.
>>
>> Agreed. Especially it also allows to test the kernel ioctl on its own,
>> without QEMU in between (which might also clear some registers), so for
>> getting the new reset ioctls right, the selftests are certainly the
>> better place.
> 
> Selftests are in development and will be up for discussion this week if
> all goes well...
> 
> While the selftest leaves QEMU out of the picture, we're still using
> kernel APIs to fetch and reset data, so actually getting guests'
> register values requires some fiddling in the guest code. So I rather
> have a test that tells me if KVM + QEMU are correct at the beginning of
> testing, since that's what most people are using anyways.

Ok, as Christian already said, it certainly can't hurt to test this in
kvm-unit-tests, too - I didn't mean that you should drop this code here,
sorry if that sounded wrong.

 Thomas

