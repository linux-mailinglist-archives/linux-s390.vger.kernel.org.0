Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40073A259
	for <lists+linux-s390@lfdr.de>; Thu, 22 Jun 2023 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjFVN6e (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 22 Jun 2023 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjFVN6b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Jun 2023 09:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71BCE2
        for <linux-s390@vger.kernel.org>; Thu, 22 Jun 2023 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687442266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GM+KaVBTG0d2ZoawOpQPP3iTozMv6kRahCWZiyW/ao=;
        b=dE63dA3mj9ln5+tXWsIQXmlaizNsyy0fLjor2NKmEQWZSNTzQP/DpTfWoWKzXEbX3znGt0
        0iFpj78wJtWj1N/KcuDNjdv2UBTRdbt2UcPte3uvGfsIjxDBFxh3muvqvqPgM4WITdDv52
        BzJwOiQDPWHS2reYwxJDI9Ti9DAcujQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-UK12tYEPO2WCGi-Thf9eaw-1; Thu, 22 Jun 2023 09:57:44 -0400
X-MC-Unique: UK12tYEPO2WCGi-Thf9eaw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f9b5cc7298so16306575e9.3
        for <linux-s390@vger.kernel.org>; Thu, 22 Jun 2023 06:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442263; x=1690034263;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9GM+KaVBTG0d2ZoawOpQPP3iTozMv6kRahCWZiyW/ao=;
        b=ICTxuTTFRJaXRwMoIICLNYebJs4g/SZB5phQysnnyx3r6zSRGXuRZqOGsOmwu0hKY9
         csdYOFz4hqOzrv2CES5dvg7znqM3Lcv18YRqeTZ9ka4GFG4utX3kGadOdgU6AKLmqEY+
         vYYUrlWIe7cNb9ScZe/3gmx2rEd6SsIzBx9cG1hhOUtmElps0hWfh7epYyUYVKeKRUXF
         Kxrn+dWl2Y+o5mYj4A8Jz5yGb4v5dLmBOhYomtE5awW8v0R3sdYZ2wL8b6S40B5A00BN
         zyOA9fDiMQOH6ssuFQQRIzudU8pZTxaKSGdvdwM1/v4W5wBykLxKgfdEY1qRuYEjtSu5
         90Yg==
X-Gm-Message-State: AC+VfDxuKww0bE3P9Moel0BIXE/45mKrfe1QYyEjPFy8Wg9C0vCv71YO
        XCnNtKoAHX24hJPrO/OU/IZDOqsqnaJVgWVBrxqwS66cEsD00RfxWrRsYHARaDG3eXclGSvU+j9
        FNC98b9leBcdkyiyRkUsPnQ==
X-Received: by 2002:a05:600c:2942:b0:3f7:5d:4a06 with SMTP id n2-20020a05600c294200b003f7005d4a06mr1531909wmd.1.1687442263389;
        Thu, 22 Jun 2023 06:57:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5p9/Up90QSZ1DAdrQMEuugJHQR/5D9norGZu6r3B4czFVgo4n6RIoxrIJViM7m10t9Bv6d/Q==
X-Received: by 2002:a05:600c:2942:b0:3f7:5d:4a06 with SMTP id n2-20020a05600c294200b003f7005d4a06mr1531890wmd.1.1687442263118;
        Thu, 22 Jun 2023 06:57:43 -0700 (PDT)
Received: from ypodemsk.tlv.csb (IGLD-84-229-250-192.inter.net.il. [84.229.250.192])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f7e4d143cfsm7832711wmi.15.2023.06.22.06.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:57:42 -0700 (PDT)
Message-ID: <c08d81286b9986c086e9b68e3440f9bf99086d70.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] mm/mmu_gather: send tlb_remove_table_smp_sync
 IPI only to MM CPUs
From:   ypodemsk@redhat.com
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     mtosatti@redhat.com, ppandit@redhat.com,
        David Hildenbrand <david@redhat.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        agordeev@linux.ibm.com,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        svens@linux.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        Arnd Bergmann <arnd@arndb.de>, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, linus.walleij@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        sebastian.reichel@collabora.com, Mike Rapoport <rppt@kernel.org>,
        aneesh.kumar@linux.ibm.com,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Date:   Thu, 22 Jun 2023 16:57:39 +0300
In-Reply-To: <10050BB1-15A4-4E84-B900-B21500B2079B@gmail.com>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
         <20230620144618.125703-3-ypodemsk@redhat.com>
         <10050BB1-15A4-4E84-B900-B21500B2079B@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2023-06-21 at 11:02 -0700, Nadav Amit wrote:
> > On Jun 20, 2023, at 7:46 AM, Yair Podemsky <ypodemsk@redhat.com>
> > wrote:
> > 
> > @@ -1525,7 +1525,7 @@ static void collapse_and_free_pmd(struct
> > mm_struct *mm, struct vm_area_struct *v
> > 				addr + HPAGE_PMD_SIZE);
> > 	mmu_notifier_invalidate_range_start(&range);
> > 	pmd = pmdp_collapse_flush(vma, addr, pmdp);
> > -	tlb_remove_table_sync_one();
> > +	tlb_remove_table_sync_one(mm);
> 
> Can’t pmdp_collapse_flush() have one additional argument
> “freed_tables”
> that it would propagate, for instance on x86 to flush_tlb_mm_range()
> ?
> Then you would not need tlb_remove_table_sync_one() to issue an
> additional
> IPI, no?
> 
> It just seems that you might still have 2 IPIs in many cases instead
> of
> one, and unless I am missing something, I don’t see why.
> 
Hi Nadav,
Thanks for your comment.
I think you are right and in some configurations 2 IPIs might occur.
However I a am not really dealing with the thp code at the moment,
This patch is about the mmu_gatherer and mostly dealing with IPIs sent
via the other code path.
Thanks,
Yair

