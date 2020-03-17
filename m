Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777BA1890F0
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2020 23:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCQWBu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 17 Mar 2020 18:01:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQWBu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 17 Mar 2020 18:01:50 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEKGu-0000tj-1m; Tue, 17 Mar 2020 23:01:12 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 71BBA101161; Tue, 17 Mar 2020 23:01:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, lkml <linux-kernel@vger.kernel.org>,
        "Schofield\, Alison" <alison.schofield@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Shutemov\, Kirill" <kirill.shutemov@intel.com>
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
In-Reply-To: <20200317210602.GG15609@zn.tnic>
References: <20200317111822.GA15609@zn.tnic> <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com> <20200317210602.GG15609@zn.tnic>
Date:   Tue, 17 Mar 2020 23:01:11 +0100
Message-ID: <87fte6bpzs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Tue, Mar 17, 2020 at 01:35:12PM -0700, Dave Hansen wrote:
>> On 3/17/20 4:18 AM, Borislav Petkov wrote:
>> > Back then when the whole SME machinery started getting mainlined, it
>> > was agreed that for simplicity, clarity and sanity's sake, the terms
>> > denoting encrypted and not-encrypted memory should be "encrypted" and
>> > "decrypted". And the majority of the code sticks to that convention
>> > except those two. So rename them.
>> 
>> Don't "unencrypted" and "decrypted" mean different things?
>> 
>> Unencrypted to me means "encryption was never used for this data".
>> 
>> Decrypted means "this was/is encrypted but here is a plaintext copy".
>
> Maybe but linguistical semantics is not the point here.
>
> The idea is to represent a "binary" concept of memory being encrypted
> or memory being not encrypted. And at the time we decided to use
> "encrypted" and "decrypted" for those two things.
>
> Do you see the need to differentiate a third "state", so to speak, of
> memory which was never encrypted?

I think so.

encrypted data is something you can't use without having the key

decrypted data is the plaintext copy of something encrypted, so
it might be of sensible nature.

unencrypted data can still be sensible, but nothing ever bothered to
encrypt it in the first place.

So having this distinction is useful in terms of setting the context
straight.

Thanks,

        tglx
