Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC002DB5FC
	for <lists+linux-s390@lfdr.de>; Thu, 17 Oct 2019 20:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503285AbfJQSWb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 17 Oct 2019 14:22:31 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41651 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503282AbfJQSWb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Oct 2019 14:22:31 -0400
Received: by mail-pf1-f182.google.com with SMTP id q7so2160852pfh.8
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 11:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=qJ6/zX4CJXyT8jN+BKjWcB5Fc+YC0TUGB76PLX5dDk8=;
        b=Yr5MnTTMEiIBv/P1NIs6Xsnk7ihLbwbohCxlrNFj8CS/usWZ/2hVpZzU+lduXxKQcv
         voioKugCroXUyZMnedwec3yi72I4tBQ0bvvGzI8F8K/RsegSKzMgF/nyMkdkiWDAU/ds
         rJdg8JZ9Jm8r8SRwRcwySieFC2aOzBXA4qcDm+EbZfynjWFq4pBWQLuEYr8+Ty3JVikL
         kiSS4dM2QGrdtuP0cepYncMNeTjDIO0Zbokr3Zz+LBeMKn0jBLX3EiIkc+VaaVSx0OyK
         8BHGqKcPXrh7Y0cjewpCiVgDrrhUMoGruvTKtlU1PEcR36TpJk+Ac/jKxgAcUsd2+G+o
         fkBA==
X-Gm-Message-State: APjAAAX1z54QLlOoVb1R8gY68gg055BbzHl83SFh74f3ybeJsNtVfnQO
        0MzXnDN0YFt1OLlWTrX/VxNYKw==
X-Google-Smtp-Source: APXvYqyJNHvaSBqrZiRuB0+cioJyGR8wen484kCJG+fmxEESVRjqBPiqSzXAunoRqzPXJMJEDNhhdA==
X-Received: by 2002:a62:b504:: with SMTP id y4mr1684760pfe.198.1571336549961;
        Thu, 17 Oct 2019 11:22:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p190sm3078797pfb.160.2019.10.17.11.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:22:29 -0700 (PDT)
Subject: PCI/MSI: Remove the PCI_MSI_IRQ_DOMAIN architecture whitelist
Date:   Thu, 17 Oct 2019 11:19:34 -0700
Message-Id: <20191017181937.7004-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        kstewart@linuxfoundation.org, pbonzini@redhat.com,
        firoz.khan@linaro.org, yamada.masahiro@socionext.com,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com,
        helgaas@kernel.org
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This came up in the context of the microblaze port, where a patch was
recently posted to extend the whitelist.


