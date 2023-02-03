Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4038D688E03
	for <lists+linux-s390@lfdr.de>; Fri,  3 Feb 2023 04:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjBCDcI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 2 Feb 2023 22:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjBCDcG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Feb 2023 22:32:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756F68AE2
        for <linux-s390@vger.kernel.org>; Thu,  2 Feb 2023 19:31:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso7619611pjj.1
        for <linux-s390@vger.kernel.org>; Thu, 02 Feb 2023 19:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ELdr8kr8cfAFHro3oo2nX8Zeaf+T1iI5OEPVbajWl4=;
        b=jCJnuaG7D0JNqsasbCOptl2FERdbLdwSDouVdFGzdlhZ4c0vC6kncai50bmmbcG/DW
         Sb7Q7TTuIW399D57jto6QS7jK7rNGJfTigkW4VVmK8ixDAHFWk+AjRyf/EIoK4SW+kaf
         4oqgE3ORR+Kae4q0iDp42Aaevi8KRRznIjekikScXpDDIySq4G+W3WG5YRVSvm90lcLs
         i6r167TOVqnrFS1cchC+nMQa+SdsnBqvWgEziNgvGavPegJwuoxvGFv5fZH+5rwlJWHS
         uRjz49UFgst62dCFszB9MGisu5ceibyxM/Q2gNIrFfVIWNN41LF4scop8rJgL2j92Zaw
         Yzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ELdr8kr8cfAFHro3oo2nX8Zeaf+T1iI5OEPVbajWl4=;
        b=mgvFynpUkINt8CbOHuo8UunL497lR22lb3OnKSp8Suh34YdCTOHUDvP+mAU92Tdizr
         XmwVKMOKnTAQ3hYsJTApNNHlJQQsbnlVM0ItbCo5BFIScFWll8mEiqXnwpCnjAvzSP81
         g4QHD1S9vSxSA7qwtsqhv9VDfxSFGlQfScOuCdNH03I6Mr3W0xB3NLd3fW225lmC31cX
         WJM7g3m/XkFD1gi4Oa9iY8BvFUx7whVDTXAckzg3dqHYyqy4teguVCGxMwdYMiAoUP5I
         +NUbITXF/qIydqtpJL5Nrf+R4CauQxVkIicI2qSOOXBXl1qKd7t74suwX7NJ8SzV1/lT
         3EnA==
X-Gm-Message-State: AO0yUKWY/GMq/Gp0mlOBLdfRy3WetQcLh9fSmocCQ0wuefhznNhCho7e
        XOsKt7wwS/mBudy7Ou4HXS3a0L0dDCuz4hbD
X-Google-Smtp-Source: AK7set+57aLnObSHcH5qlDN6Mf7iQBt+c9eQWgNCT+CmyqH0+99UE+sJruvk7QuheXFpwkAyk9dl8g==
X-Received: by 2002:a17:903:41ca:b0:198:d8a4:1ece with SMTP id u10-20020a17090341ca00b00198d8a41ecemr1658070ple.8.1675395117606;
        Thu, 02 Feb 2023 19:31:57 -0800 (PST)
Received: from localhost ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902edd000b001966308ca0dsm420998plk.167.2023.02.02.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 19:31:56 -0800 (PST)
Date:   Thu, 02 Feb 2023 19:31:56 -0800 (PST)
X-Google-Original-Date: Thu, 02 Feb 2023 19:31:51 PST (-0800)
Subject:     Re: [PATCH 0/5] mm: Stop alaising VM_FAULT_HINDEX_MASK in arch code
In-Reply-To: <20221203030356.3917-1-palmer@rivosinc.com>
CC:     linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Message-ID: <mhng-15cb5600-7883-4454-aabe-6e695a81a45c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 02 Dec 2022 19:03:51 PST (-0800), Palmer Dabbelt wrote:
> When reviewing
> <https://lore.kernel.org/r/20221029084715.3669204-1-tongtiangen@huawei.com>
> I noticed that the arch-specific VM_FAULT flags used by arm and s390
> alias with VM_FAULT_HINDEX_MASK.  I'm not sure if it's possible to
> manifest this as a bug, but it certainly seems fragile.
>
> The RISC-V patch is on top of the linked patch above, which isn't in any
> proper tree yet.  Everything else should apply to 6.1-rc1, but I'm in no
> particular rush to get that cleanup in so rush on my end for 6.2.  That
> said I figured it would be easier to send along this now, just in case
> someone who knows the MM code better thinks it can manifest as a bug.

Just pinging this one, I'm not sure if it was just bad timing on the 
last one.  That RISC-V patch is still sitting around outside my tree.
