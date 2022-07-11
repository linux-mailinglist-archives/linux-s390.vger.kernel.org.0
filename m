Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2FE568869
	for <lists+linux-s390@lfdr.de>; Wed,  6 Jul 2022 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiGFMeo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 Jul 2022 08:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiGFMen (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Jul 2022 08:34:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB28EE04
        for <linux-s390@vger.kernel.org>; Wed,  6 Jul 2022 05:34:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso6804393pjz.0
        for <linux-s390@vger.kernel.org>; Wed, 06 Jul 2022 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=hW2431492sCVZamN/p5cUoH7v2KxbwYiYFtMhbuxSSs=;
        b=aO/ZC+U5LATGWzsMenvtODpWhcejLQ4DmRLha/4SFn11Wf8DcIrFk1B5B3fP0AvXUg
         F1PUOqzt04jGHL+kW42wdhfxoatgfieaCaFTjTsg/0aPS0d1NSqzbVAWUr48FwKbi2kk
         bNQBektjLeeE1K2U1dLcbw68C5O909m3ltoYOt5psp5Gsf6ooUgQxbp7vtkJxaFCNVLq
         JB5JDSboVX7gNuCr6BqOEB2T1vnXsuL9FxkeVt6f0+RSoxgWygebchQshMWMnbZdv7Xg
         QtsTjaAJP4QGjnj40SClqvGtAh7oHGQx9EV2mY92w7wDa5vthlOb4om9GVvEhy9g8Ujc
         ZNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=hW2431492sCVZamN/p5cUoH7v2KxbwYiYFtMhbuxSSs=;
        b=doHzfXHR3hmNhjMjekDPt3Pz2XmhCuZ7+3JXCTyR18+v+UbGRkN1DlUUiv6xMAiLUJ
         yQYSiP6U49gxQbIs5OKpqQr30ZLmzwPCsfpLdeSOr6ArzHpv0WdTngFRn0aNMLMQ2Xqw
         jPQA4wes6cd05VO+rHR5OIiA6Qk2o0sBtfzDfkSLi8/uHqNvutPilrgZYxjfNU0SqmfY
         /1ljulIvbD3EIF7F8ysuJY3D63mbFWUJwQQuEPHPuF7e7SEhHW2ydk5y5IvuTGjQ/JCZ
         DHPfbxaG9vBbAGz7hwVeh35yeTNsmRp4P8jowQycBmnqxp9XAre4f0zNSL0KxtfF0YY0
         ohaw==
X-Gm-Message-State: AJIora/Ymj016ZlVI14Tr4tU6cHBhbHscnFSKw75vQF8syTFTl4HFj8f
        0NEntoz/lAFTkCw2omqNB+h4cQ==
X-Google-Smtp-Source: AGRyM1szJSqnPFX6luEMhyzzQ0Aeywhddc3vVY3+ZKqUe4ppobSQfJg1kQYfqyNYWH89tB/Ll0NihQ==
X-Received: by 2002:a17:902:ab42:b0:16c:66d:c44d with SMTP id ij2-20020a170902ab4200b0016c066dc44dmr1314197plb.125.1657110880402;
        Wed, 06 Jul 2022 05:34:40 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 84-20020a621957000000b005289cade5b0sm2634560pfz.124.2022.07.06.05.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:34:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jejb@linux.ibm.com, hare@suse.de, kartilak@cisco.com,
        Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com,
        satishkh@cisco.com, sebaddel@cisco.com,
        damien.lemoal@opensource.wdc.com, john.garry@huawei.com,
        bvanassche@acm.org
Cc:     linux-nvme@lists.infradead.org, nbd@other.debian.org,
        linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
References: <1657109034-206040-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH v3 0/6] blk-mq: Add a flag for reserved requests series
Message-Id: <165711087866.291548.18135186803736478100.b4-ty@kernel.dk>
Date:   Wed, 06 Jul 2022 06:34:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 6 Jul 2022 20:03:48 +0800, John Garry wrote:
> Can you please consider this series? Thanks
> 

Applied, thanks!

[1/6] scsi: core: Remove reserved request time-out handling
      commit: deef1be18e3fc62ddf04fb3e5e8ff6a301693dcc
[2/6] blk-mq: Add a flag for reserved requests
      commit: 99e48cd6855e9535488e3c90d65edd46c6e6fc1b
[3/6] blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
      commit: 9bdb4833dd399cbff82cc20893f52bdec66a9eca
[4/6] scsi: fnic: Drop reserved request handling
      commit: 1263c1929fb8c375494666ec6d1bac838ff02c25
[5/6] blk-mq: Drop 'reserved' arg of busy_tag_iter_fn
      commit: 2dd6532e9591f201e7571b30915db807603ab924
[6/6] blk-mq: Drop local variable for reserved tag
      commit: 4cf6e6c0106bf6e6d034fa6043b4428ac2f267fc

Best regards,
-- 
Jens Axboe


